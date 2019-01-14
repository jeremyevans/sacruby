DATA.each_line do |line|
  print line if (line =~ /\Abegin/)..(line =~ /\Aend/)
end

__END__

1
begin1
2
end1
3
begin2
end2
4
