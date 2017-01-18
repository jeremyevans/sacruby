p File.empty?(__FILE__)
p Dir.empty?(__dir__)
require 'pathname'
p Pathname.new(__FILE__).empty?
