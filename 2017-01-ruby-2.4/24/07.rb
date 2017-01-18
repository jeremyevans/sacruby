module Foo
  refine String do
    def a; 1; end
  end
end

using Foo
meth = :a
p 'a'.send(meth)
p 'ab'.each_char.map(&meth)
