arys = [[:x], [:x, :y], [:x, :y, :z]]
arys.each do |ary|
  case ary.length
  when 1
    p [1, ary[0]]
  when 2
    p [2, ary[0], ary[1]]
  else
    raise RuntimeError
  end
end
