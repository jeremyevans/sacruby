puts("favorite ruby libraries".tap do |s|
  s.split.each{|word| puts word unless word.start_with?('f') }
end)
