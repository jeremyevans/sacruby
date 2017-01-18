module Foo
  refine String do
    def a; 1; end
  end
end

using Foo
meth = :a
eval <<END
using Foo
p 'a'.#{meth}
p 'ab'.each_char.map{|s| s.#{meth}}
END
