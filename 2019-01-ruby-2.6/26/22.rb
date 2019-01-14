raise KeyError.new("foo", receiver: {}, key: 1) rescue p [$!.receiver, $!.key]
raise NameError.new("bar", receiver: 'a') rescue p $!.receiver
