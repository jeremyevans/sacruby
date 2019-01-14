begin
  begin
    raise "foo"
  rescue
    begin
      raise "bar"
    rescue
      raise "baz"
    end
  end
rescue => e
  while e
    puts e.full_message.gsub('25', '26')
    e = e.cause
  end
end
