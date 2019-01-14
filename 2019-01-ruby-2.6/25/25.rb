p File.open(IO.sysopen('a', File::EXCL | File::WRONLY | File::CREAT)){|f| f}
p File.open(IO.sysopen('a', File::EXCL | File::WRONLY | File::CREAT)){} rescue File.delete('a')
