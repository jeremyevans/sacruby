p File.open('a', 'wx'){|f| f}
p File.open('a', 'wx'){} rescue File.delete('a')
