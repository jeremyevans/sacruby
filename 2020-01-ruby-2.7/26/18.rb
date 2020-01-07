com_cmp = lambda do |a,b|
  if a.imag == 0 && Complex(b).imag == 0
    a.real <=> b.real
  end
end
com_cmp.call(1 + 0i, 1 + 0i)
com_cmp.call(1 + 0i, 2)
com_cmp.call(1 + 0i, 0.0)
com_cmp.call(1 + 2i, 1 + 2i)
