Thread.new do
  Thread.current.report_on_exception = true
  raise  'foo'
end
sleep 0.01
