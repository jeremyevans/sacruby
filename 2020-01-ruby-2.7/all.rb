#!/usr/local/bin/ruby27

examples = (<<END).split("\n")
Pattern matching
Keyword argument separation
Module#ruby2_keywords
Non-Symbol keys in keywords
**nil parameter
**{} doesn't pass argument
... argument forwaring
Numbered parameters
Beginless range
GC.compact
IRB improvements
self.private_method allowed
Refinements in method/instance_method
Method#inspect arguments and location
UnboundMethod#bind_call
Module#const_source_location
Comparible#clamp Range handling
Complex#<=>
{nil,true,false}.to_s frozen strings
Symbol\#{start,end}_with?
Time#\#{floor,ceil}
Enumerable#filter_map
Enumerable#tally
Array#intersection
Fiber#raise
FrozenError#receiver
Warning[]
yield in singleton class deprecated
Implicit block capturing deprecated
$SAFE and taining deprecated
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
