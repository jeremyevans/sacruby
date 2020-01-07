class A
  def b
    a = 1
    a + self.a
  end
  private def a; 2 end
  p new.b
end
