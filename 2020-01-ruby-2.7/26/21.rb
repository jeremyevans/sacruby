p Time.at(Time.now.to_f.floor)
p Time.at(Time.now.to_f.ceil)
puts Time.at(Time.now.to_f.floor(2)).strftime('%F %T.%2N %z')
puts Time.at(Time.now.to_f.ceil(3)).strftime('%F %T.%3N %z')
