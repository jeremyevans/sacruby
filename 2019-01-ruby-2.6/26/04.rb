module StringSQL
  refine String do
    def to_sql
      "'#{gsub("'", "''")}'"
    end

    def to_proc
      eval("proc{|*a, &block| #{self}(*a, &block)}")
    end
  end
end

using StringSQL
p "fo'o".to_sql
p "fo'o".respond_to?(:to_sql)
p "fo'o".public_send(:to_sql) rescue p(:error)
p [1,2,3].map(&"String") rescue p(:error)
