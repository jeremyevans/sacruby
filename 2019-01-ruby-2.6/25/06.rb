y = 1.
  yield_self{|x| p x; x + 1}.
  yield_self{|x| p x; x * 2}.
  yield_self{|x| p x; x ** 3}
p y

