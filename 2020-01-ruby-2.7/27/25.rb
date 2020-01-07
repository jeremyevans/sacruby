f = Fiber.new{|x| p x; Fiber.yield 2}
p(f.resume 1)
f.raise "foo"
