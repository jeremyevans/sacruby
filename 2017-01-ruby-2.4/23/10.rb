# No equivalent
o = Object.new
def o.foo; 1 end
o.freeze

begin
x = o.clone
def x.bar; foo + 2 end
p x.bar
rescue
  p $!
end

begin
x = o.dup
def x.bar; foo + 2 end
x.freeze
p x.bar
rescue
  p $!
end

