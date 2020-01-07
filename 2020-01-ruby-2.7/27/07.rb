def a(...) b(...) end
def b(*a, **kw, &block) [a, kw, block.class] end
p a(1, a: 1)
p a(1){}
