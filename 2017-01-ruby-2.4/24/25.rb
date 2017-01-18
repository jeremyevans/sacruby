module Foo
  refine Enumerable do
    def a; 1 end
  end
end

using Foo
p [].a
