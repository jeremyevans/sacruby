puts (raise rescue 1)
begin
  eval('puts(raise rescue 1)')
rescue SyntaxError
  puts "Still Bad"
end
