begin
  system('cat does-not-exist.txt') || if $?.exitstatus == 127
    raise(Errno::ENOENT, "cat")
  else 
    raise(RuntimeError, "Command failed with exit #{$?.exitstatus}: cat")
  end
rescue
  p $!
end

begin
  system('cat2 does-not-exist.txt') || if $?.exitstatus == 127
    raise(Errno::ENOENT, "cat2")
  else 
    raise(RuntimeError, "Command failed with exit #{$?.exitstatus}: cat2")
  end
rescue
  p $!
end
