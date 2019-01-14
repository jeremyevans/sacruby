#!/usr/local/bin/ruby26

i = ARGV.first.to_i
file = "#{sprintf('%02i', i)}.rb"

file26 = "26/#{file}"
file25 = "25/#{file}"

puts "# Ruby 2.6"
puts File.read(file26)
$stdin.gets
puts "# Ruby 2.6 Output"
output26 = `ruby26 #{file26} 2>&1`
puts output26
$stdin.gets

if File.file?(file25)
  puts "# Ruby 2.5 Equivalent"
  puts
  puts File.read(file25)
  puts
else
  file25 = file26
end

output25 = `ruby25 #{file25} 2>&1`
if output25 == output26
  puts "# Same Output in Ruby 2.5"
else
  if file25 == file26
    puts "# Ruby 2.5 Output"
  else
    puts "# Ruby 2.5 Equivalent Output"
  end

  puts output25
end
