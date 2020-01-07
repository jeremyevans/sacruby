Warning[:deprecated] = false
def a(**kw) kw end
a({x: 1})
def b(x, **kw) [x, kw] end
b(y: 1)
def c(x=1, z:1) [x, z] end
c(z: 1, 2 => 3)
