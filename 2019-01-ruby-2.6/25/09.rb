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

p B.instance_methods(false).include?(:a)
p B.public_instance_methods(false).include?(:a)
p B.protected_instance_methods(false).include?(:b)
p B.private_instance_methods(false).include?(:c)
p B.instance_methods(false).include?(:d)
