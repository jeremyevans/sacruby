require 'optparse'
h = {}
OptionParser.new do |o|
  o.on "-f", "--foo=HOST" do |v|
    h[:foo] = v
  end
  o.on "-b", "--bar=PORT", Integer do |v|
    h[:bar] = v
  end
  o.on "-B", "--baz" do
    h[:baz] = true
  end
end.parse(%w'-f FOO --bar 3 -B')
p h
