p ((x = 'foo'.casecmp('Foo')).is_a?(Integer) ? x.zero? : x)
p ((x = :foo.casecmp(:Bar)).is_a?(Integer) ? x.zero? : x)
