#!/usr/local/bin/ruby24

examples = (<<END).split("\n")
Regexp/String/Symbol#match?
Thread report_on_exception
Binding#irb
Fixnum/Bignum -> Integer
{String,Symbol}\#{upcase,downcase,swapcase,capitalize}
Multiple Assignment in Conditionals
Symbol#to_proc, Kernel#send Respect Refinements
Method Argument Parsing Corner Case Fixed
Top Level return
Kernel#clone :freeze
Warning.warn
{Enumerable,Array}#sum
Enumerable#uniq
{File,Dir}.empty?, Pathname#empty?
MatchData#named_captures, #values_at
Integer#digits
Float\#{ceil,floor,truncate,round} argument
Float/Rational#round :half 
Symbol#match returns MatchData
Array/String#concat, String#prepend Multiple Arguments
Comparable#clamp
Hash#compact
Hash#transform_values
IO/StringIO/String :chomp
Module#refine with module
Module.used_modules
String#unpack1
Array#pack :buffer
{String,Symbol}#casecmp?
Net::HTTP.post
Net::FTP :ssl
TRUE/FALSE/NIL
Logger.new :level, :progname
OptionParser#parse :into
Numeric#finite?, #infinite?
String.new(:capacity=>1<<30)
END

initial = ARGV.first.to_i

examples.each_with_index do |e, i|
  next if i+1 < initial
  s = "#{i+1}. #{e}"
  puts
  puts s
  puts('-' * s.length)
  $stdin.gets
  break unless system('runner.rb', (i+1).to_s)
  $stdin.gets
end
