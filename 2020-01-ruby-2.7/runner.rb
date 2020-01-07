#!/usr/local/bin/ruby27

i = ARGV.first.to_i
file = "#{sprintf('%02i', i)}.rb"

file27 = "27/#{file}"
file26 = "26/#{file}"

puts "# Ruby 2.7"
puts File.read(file27)
$stdin.gets
puts "# Ruby 2.7 Output"
output27 = `ruby27 #{file27} 2>&1`
puts output27
$stdin.gets

if File.file?(file26)
  puts "# Ruby 2.6 Equivalent"
  puts
  puts File.read(file26)
  puts
else
  file26 = file27
end

output26 = `ruby26 #{file26} 2>&1`
if output26 == output27
  puts "# Same Output in Ruby 2.6"
else
  if file26 == file27
    puts "# Ruby 2.6 Output"
  else
    puts "# Ruby 2.6 Equivalent Output"
  end

  puts output26
end
