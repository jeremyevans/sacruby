require 'date'

today = Date.today
[-2, -1, 0, 1, 2].each do |x|
  case DateTime.now + x - DateTime.now.offset
  when (today-1)...today
    p :yesterday
  when today...(today+1)
    p :today
  when (today+1)...(today+2)
    p :tomorrow
  else
    p :neither
  end
end
