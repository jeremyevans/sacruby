def a(x)
  class << x
    yield self
  end
end
a(""){|x| p x}
