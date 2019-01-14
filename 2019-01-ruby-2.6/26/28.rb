def a(binding)
  p binding.source_location
  p binding.eval('a')
end
a = 2
a(binding)
