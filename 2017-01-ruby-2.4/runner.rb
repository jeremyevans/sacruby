#!/usr/local/bin/ruby24

i = ARGV.first.to_i
file = "#{sprintf('%02i', i)}.rb"

file24 = "24/#{file}"
file23 = "23/#{file}"

puts "# New in Ruby 2.4"
puts File.read(file24)
$stdin.gets
puts "# Output"
output24 = `ruby24 #{file24} 2>&1`
puts output24
$stdin.gets

puts "# Ruby 2.3 Equivalent"
puts File.read(file23)
output23 = `ruby23 #{file23} 2>&1`
unless output23 == output24
  puts
  puts "# Ruby 2.3 Equivalent Output"
  puts output23
end
