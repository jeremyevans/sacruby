h = {}
[1,2,2,3,3,4,2].each { |k|
  h[k] = h.fetch(k, 0) + 1
}
p h
