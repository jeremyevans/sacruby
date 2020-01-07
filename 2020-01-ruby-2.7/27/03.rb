ruby2_keywords def b(*a) c(*a) end
def c(**kw) kw end
p b(a: 2)
