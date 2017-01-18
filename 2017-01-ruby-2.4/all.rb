#!/usr/local/bin/ruby24

examples = (<<END).split("\n")
Regexp/String/Symbol#match?
Thread#report_on_exception and Thread.report_on_exception
Binding#irb
Fixnum/Bignum Are Now Unified Into Integer
{String,Symbol}\#{upcase,downcase,swapcase,capitalize}
Multiple Assignment in Conditionals
Refinements for Symbol#to_proc and Kernel#send
Parsing Corner Case Fixed
Top Level return
Kernel#clone(:freeze=>false)
Warning.warn
{Enumerable,Array}#sum
Enumerable#uniq
{File,Dir}#empty?, Pathname#empty?
MatchData#named_captures, #values_at
Integer#digits
Float\#{ceil,floor,truncate,round} precision argument
Float/Rational#round :half option
Symbol#match returns MatchData
Array/String#concat, String#prepend Accept Multiple Arguments
Comparable#clamp
Hash#compact
Hash#transform_values
IO/StringIO/String :chomp option
Module#refine with module
Module.used_modules
String#unpack1
Array#pack :buffer
{String,Symbol}#casecmp?
Net::HTTP.post
Net::FTP TLS support
TRUE/FALSE/NIL Deprecated
Logger.new($stderr, level: :info, progname: "L2")
OptionParser.parse(:into)
Numeric#finite, #infinite
String.new(:capacity=>1024**2)
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
