add10 = proc{|x| x + 10}
mul20 = proc{|x| x * 20}

p((add10 << mul20).call(1))
p((add10 >> mul20).call(1))
