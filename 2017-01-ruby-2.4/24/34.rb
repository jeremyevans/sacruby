require 'optparse'
h = {}
OptionParser.new do |o|
  o.on "-f", "--foo=HOST"
  o.on "-b", "--bar=PORT", Integer
  o.on "-B", "--baz"
end.parse(%w'-f FOO --bar 3 -B', :into=>h)
p h
