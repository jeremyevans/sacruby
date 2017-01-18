# No equivalent
module Foo
  refine String do
    def a; 1 end
  end
end

p Module.used_modules
using Foo
p Module.used_modules
