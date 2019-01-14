def a
  p "in a"
else
  p "in a/else"
end

begin
  p "in begin"
  a
else
  p "in begin/else"
end
