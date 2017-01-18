$VERBOSE = true
def Warning.warn(s)
  puts "WARNING: #{s}" unless s =~ /instance variable @.+ not initialized/
end
instance_variable_get(:@foo)
$a
