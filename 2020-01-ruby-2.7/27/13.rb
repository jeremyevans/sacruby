module R
  refine Float do
    def /(x); super * 2 end
  end
end
using R
p 1.0.method(:/).call(3)
