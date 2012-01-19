require 'rubygems'
require 'sinatra/base'
require 'models'
require 'forme/sinatra'
require 'rack-flash'
require 'scaffolding_extensions'

class SacRubyBase < Sinatra::Base
  disable :run
  enable :static
  set :app_file, __FILE__ 
  
  PUBLIC_PAGES = %w[/application.css /favicon.ico /login /logout /register]
  
  helpers Forme::Sinatra::ERB
  helpers do
    def h(s)
      Rack::Utils.escape_html(s.to_s)
    end

    def member
      @member ||= Member[session[:member_id]]
    end

    def admin?
      session[:member_admin]
    end

    def member_id
      session[:member_id]
    end
    alias logged_in? member_id
  end
end

class SacRuby < SacRubyBase
  before do
    redirect('/login', 303) unless logged_in? || PUBLIC_PAGES.include?(request.env['PATH_INFO'])
  end

  get('/') do
    @meetings = Meeting.upcoming(session[:member_id])
    erb :index
  end

  get('/meeting/:id') do
    @meeting = Meeting[params[:id].to_i]
    @attending = @meeting.attending?(member_id)
    erb :meeting
  end

  post('/meeting/:id/attend') do
    halt('Must specify attend') unless attend = params[:attend]
    if DB[:meeting_attendence].filter(:member_id=>member_id, :meeting_id=>params[:id].to_i).update(:attending=>attend == 't') == 0
      DB[:meeting_attendence].insert(:member_id=>member_id, :meeting_id=>params[:id].to_i, :attending=>attend == 't')
    end
    redirect("/meeting/#{params[:id].to_i}")
  end

  get '/register' do
    @member = Member.new
    erb :new
  end

  REGISTER_FIELDS =  [:email, :name, :password]
  post '/register' do
    @member = Member.new.set_fields(params[:member], REGISTER_FIELDS)
    if @member.save
      redirect('/')
    else
      erb :new
    end
  end
  
  get '/login' do
    redirect('/') if logged_in?
    erb :login
  end
  
  post '/login' do
    session.clear
    if @member = Member.login(params[:email].to_s, params[:password].to_s)
      session[:member_id] = @member.id
      session[:member_name] = @member.name
      session[:member_email] = @member.email
      session[:member_admin] = @member.admin?
      redirect('/')
    else
      @error = "Couldn't login, no matching email/password combination"
      erb :login
    end
  end

  post '/logout' do
    session.clear
    redirect('/login')
  end
end

class SacRubySE < SacRubyBase
  set :views, 'manage_views'

  before do
    redirect('/login', 303) unless admin?
  end

  scaffold_all_models :only=>[Meeting]
end

class FileServer
  def initialize(app, root)
    @app = app
    @rfile = Rack::File.new(root)
  end
  def call(env)
    res = @rfile.call(env)
    res[0] == 200 ? res : @app.call(env)
  end
end

SacRubyApp = Rack::Builder.app do
  use FileServer, 'public'
  use Rack::Session::Cookie, :secret=>'foobar'
  use Rack::Flash

  map "/" do
    run SacRuby
  end
  map "/manage" do
    run SacRubySE
  end
end
