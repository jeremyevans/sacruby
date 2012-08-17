class Bracket
  attr_reader :brackets

  def initialize(players)
    players = players.sort_by{rand}
    i = 1
    while players.length > i
      i *= 2
    end
    (i - players.length).times do |i|
      players.insert(i*2+1, nil)
    end
    @brackets = [players]
    until @brackets.last.length == 1
      @brackets << @brackets.last.each_slice(2).map do |a, b|
        b.nil? ? a : choose_winner(a, b)
      end
    end
  end

  def choose_winner(a, b)
    rand > 0.5 ? a : b
  end

end

Bracket.new(%w'a b c d e').brackets.each do |b|
  p b
end

require 'sinatra'
require 'erb'

get '/' do
  erb :enter_names
end

post '/' do
  @b = Bracket.new(params[:players].split).brackets
  @rows = @b.first.length
  @columns = @b.length
  erb :show_brackets
end
