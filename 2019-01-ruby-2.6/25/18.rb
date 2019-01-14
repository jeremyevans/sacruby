chainer = proc do |*enums|
  Enumerator.new do |y|
    enums.each do |enum|
      enum.each{|x| y << x}
    end
  end
end
p chainer.call([1,2,3], [3,4,5]).to_a
p chainer.call([1,2,3].each, [3,4,5].each).to_a

