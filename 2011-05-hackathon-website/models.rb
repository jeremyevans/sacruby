require 'rubygems'
require 'sequel'
require 'bcrypt'
require 'logger'
$:.unshift '../forme/lib'

if ENV['SACRUBY_TEST']
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres:///sacruby_test?user=sacruby')
else
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres:///sacruby?user=sacruby')
end
#DB.loggers << Logger.new($stdout)

Sequel::Model.raise_on_typecast_failure = false
Sequel::Model.plugin :validation_helpers

ATTENDING = {true=>'Attending', false=>'Not Attending', nil=>'Undecided'}

Dir['models/*'].each{|f| require f}
