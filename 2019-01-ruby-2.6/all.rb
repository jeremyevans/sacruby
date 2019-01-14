#!/usr/local/bin/ruby24

examples = (<<END).split("\n")
Endless range
Non-ASCII constant names
else without rescue in exception handling now SyntaxError instead of warning
More methods respect refinements
Flip-flops deprecated
Kernel#then alias for #yield_self
Kernel\#{Integer,Float,Rational,Complex,BigDecimal} exception keyword argument
Kernel#system exception keyword argument
Module\#{,private_,protected_,public_}method_defined? inherit argument
String#split accepts block
Time supports timezones
{Proc,Method}\#{>>,<<} for function composition
Array#union and #difference
Hash#merge with multiple arguments
Enumerable#filter and #filter! aliases for #select and #select!
Enumerable#to_h accepts block
Enumerator#ArithmeticSequence
Enumerator chaining
Range#=== uses #cover?
Range#cover? supports ranges
Range#% alias for #step
{NameError,KeyError}#initialize keyword arguments for :receiver and :key
Automatic exception printing includes cause(s)
Dir#each_child and #children
IO mode 'x' for expecting file not to exist when opening
Object#=~ deprecated
Random.bytes
Binding#source_location
RubyVM#resolve_feature_path
RubyVM::AbstractSyntaxTree
Accessing private constant calls const_missing
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
