File.open('runner.rb').each_line(chomp: true){|l| p l; break}
StringIO.new("a\nb\n").each_line(chomp: true){|l| p l}
"a\nb\n".each_line(chomp: true){|l| p l}
p "a\nb\n".lines(chomp: true)
