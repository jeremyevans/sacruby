f = 12.5
p ((f.round - f == 0.5) ? (f.round.odd? ? f.round - 1 : f.round) : f.round)
p f.round
p ((f.round - f == 0.5) ? f.round - 1 : f.round)
