p [1,2,3].select{|x| x > 1}
a = [1,2,3]
a.select!{|x| x > 1}
p a
