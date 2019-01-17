class A
  B = 1
  private_constant :B
  p B

  def self.const_missing(c)
    p c
    if c == :B
      warn "A::B is now private", uplevel: 1
      B
    else
      super
    end
  end
end
p A::B
