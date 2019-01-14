a = 1..4
b = 2..3
p(a.begin <= b.begin && a.end >= b.end)
b = 2..4
p(a.begin <= b.begin && a.end >= b.end)
a = 1...4
p(a.begin <= b.begin && a.end > b.end)
