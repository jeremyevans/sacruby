module X
  def foo(x); [self, :foo, x] end
end
p X.instance_method(:foo).bind(1).call(2)
