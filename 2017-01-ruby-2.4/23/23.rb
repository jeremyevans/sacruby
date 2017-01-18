p({a: 1, b: nil}.inject({}){|a, (k,v)| a[k] = !v; a})
