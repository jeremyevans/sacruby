s = StringIO.new <<END
a
b
a
c
END
p s.each_line.uniq
