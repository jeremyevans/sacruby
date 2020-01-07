begin
  "A".freeze[1] = 'B'
rescue FrozenError => e
  p e.receiver
end
