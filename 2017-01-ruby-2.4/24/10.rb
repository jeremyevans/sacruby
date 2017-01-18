o = Object.new
def o.foo; 1 end
o.freeze
x = o.clone(freeze: false)
def x.bar; foo + 2 end
x.freeze
p x.bar
