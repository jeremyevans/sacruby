def a(binding)
  p binding.eval("[__FILE__.sub('25', '26'), __LINE__]")
  p binding.eval('a')
end
a = 2
a(binding)
