class A
  def foo(x, y, *a, **kw); end
end
p A.new.method(:foo)
