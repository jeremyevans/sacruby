begin
  system('cat does-not-exist.txt', exception: true)
rescue
  p $!
end

begin
  system('cat2 does-not-exist.txt', exception: true)
rescue
  p $!
end
