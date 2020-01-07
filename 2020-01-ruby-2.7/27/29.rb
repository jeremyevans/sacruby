def a(x)
  Proc.new.call(x)
end
a(:b){|x| p x}
