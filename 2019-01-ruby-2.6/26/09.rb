module A
  def a; end
  protected def b; end
  private def c; end
end

class B
  include A
  def d; end
end

p B.method_defined?(:a)
p B.public_method_defined?(:a)
p B.protected_method_defined?(:b)
p B.private_method_defined?(:c)
p B.method_defined?(:d)

p B.method_defined?(:a, false)
p B.public_method_defined?(:a, false)
p B.protected_method_defined?(:b, false)
p B.private_method_defined?(:c, false)
p B.method_defined?(:d, false)
