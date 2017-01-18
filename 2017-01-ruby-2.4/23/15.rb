m = 'food'.match(/(?<a>.)(?<b>..)(?<c>.)/)
p m.names.inject({}){|a, n| a[n] = m[n]; a}
p [:a, :b, :c].map{|c| m[c]}
