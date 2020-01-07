arys = [[:x], [:x, :y], [:x, :y, :z]]
arys.each do |ary|
  case ary
  in [a]
    p [1, a]
  in [a,b]
    p [2, a, b]
  end
end
