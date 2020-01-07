def b(*a, **kw) c(*a, **kw) end
def c(*a) a end
p b(1, a: 1)
p b(1)
