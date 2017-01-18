File.open('runner.rb').each_line{|l| p l.chomp; break}
StringIO.new("a\nb\n").each_line{|l| p l.chomp}
"a\nb\n".each_line{|l| p l.chomp}
p "a\nb\n".lines.map(&:chomp)
