p((Integer('a') rescue nil))
p((Float('a') rescue nil))
p((Rational('a') rescue nil))
p((Complex('a') rescue nil))

require 'bigdecimal'
p((BigDecimal('a') rescue nil))
