
begin
  raise "foo"
rescue
  begin
    raise "bar"
  rescue
    raise "baz"
  end
end
