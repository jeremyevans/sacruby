add10 = proc{|x| x + 10}
mul20 = proc{|x| x * 20}

p(proc{|x| add10.call(mul20.call(x))}.call(1))
p(proc{|x| mul20.call(add10.call(x))}.call(1))

