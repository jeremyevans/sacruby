m = 'food'.match(/(?<a>.)(?<b>..)(?<c>.)/)
p m.named_captures
p m.values_at(:a, :b, :c)
