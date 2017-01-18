p File.zero?(__FILE__)
p Dir.new(__dir__).entries.length == 2
require 'pathname'
p File.zero?(Pathname.new(__FILE__).to_s)
