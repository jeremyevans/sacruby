def a(*a, &block) b(*a, &block) end
def b(*a, **kw, &block) [a, kw, block.class] end
p a(1, a: 1)
p a(1){}
