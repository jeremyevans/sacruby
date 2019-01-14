p({a: 1, b: 2, c: 3}.merge({b: 4, d: 5}, {d: 6, c: 7}))

p({a: 1, b: 2, c: 3}.merge({b: 4, d: 5}, {d: 6, c: 7}) do |key, old, new|
  old
end)
