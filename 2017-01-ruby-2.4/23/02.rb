Thread.new do
  begin
    raise 'foo'
  rescue Exception => e
    puts "#{Thread.current} terminated with exception:"
    puts "#{e.backtrace.first}: #{e.message} (#{e.class})"
  end
end
sleep 0.01

