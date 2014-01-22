class SimFrost
  ICE = 1
  VAPOR = 2

  def initialize(width=168, height=42, vapor_chance=rand)
    @ticks = 0
    @width = width.to_i
    @height = height.to_i
    @field = (1..@height).map{(1..@width).map{VAPOR if rand < vapor_chance}}
    @field[@height/2][@width/2] = ICE
    @vapor_chance = vapor_chance
  end

  def cell(v)
    case v
    when ICE
      '*'
    when VAPOR
      '.'
    else
      ' '
    end
  end

  def to_s
    s = "\n"
    s << '-' * (@width + 2)
    s << "\n"
    @field.each do |row| 
      s << "|"
      row.each{|v| s << cell(v)}
      s << "|\n"
    end
    s << '-' * (@width + 2)
    s << "\n"
  end

  def vapor_left?
    @field.any?{|row| row.any?{|v| v == VAPOR}}
  end

  def update(x,y)
    offset = @ticks % 2

    x1 = x*2 + offset
    x2 = x1 + 1
    x2 = 0 if x2 >= @width

    y1 = y*2 + offset
    y2 = y1 + 1
    y2 = 0 if y2 >= @height

    neighborhood = [@field[y1][x1], @field[y2][x1], @field[y1][x2], @field[y2][x2]]
    #p [:before, @field[y1][x1], @field[y2][x1], @field[y1][x2], @field[y2][x2]]

    if neighborhood.include?(ICE)
       neighborhood.map!{|v| v == VAPOR ? ICE : v}
    elsif rand < 0.5
       neighborhood = neighborhood.values_at(2,0,3,1)
    else
       neighborhood = neighborhood.values_at(1,3,0,2)
    end

    @field[y1][x1], @field[y2][x1], @field[y1][x2], @field[y2][x2] = neighborhood
    #p [:after, @field[y1][x1], @field[y2][x1], @field[y1][x2], @field[y2][x2]]
  end

  def tick
    (0...(@height/2)).each{|y|(0...(@width/2)).each{|x| update(x,y)}}
    @ticks += 1
  end
end

sf = SimFrost.new(*ARGV.map{|x| x.to_f})
puts sf.to_s
while sf.vapor_left?
  sleep 1
  sf.tick
  puts sf.to_s
end

