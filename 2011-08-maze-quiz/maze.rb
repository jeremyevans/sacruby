class Maze
  attr_reader :matrix

  def initialize(str)
    @matrix = str.split("\n").map{|s| s.split("").map{|c| convert_pos(c)}}
    @rows = @matrix.length
    @cols = @matrix.first.length
    @starts = find_starts
    @current_step = 0
    @starts.each{|i, j| @matrix[i][j] = 0}
  end

  def solvable?
    steps > 0
  end

  def steps
    return @steps if @steps
    current_positions = @starts
    step_count = 0
    loop do
      p [:starting_step, step_count, current_positions]
      case current_positions = next_steps(current_positions, step_count += 1)
      when Integer
        return @steps = current_positions
      when []
        return @steps = 0
      end
    end
  end

  private

  def p(*)
  end
  def puts(*)
  end

  def next_steps(current_positions, step_count)
    new_positions = []
    current_positions.each do |pos|
      i, j = pos
      [[i+1, j], [i-1, j], [i, j+1], [i, j-1]].each do |i1, j1|
        if i1 >= 0 && i1 < @rows && j1 >= 0 && j1 < @cols 
          case @matrix[i1][j1]
          when :end
            return step_count
          when false, Integer
            next
          when true
            p [:new_step, step_count, i1, j1]
            @matrix[i1][j1] = step_count
            new_positions << [i1, j1]
          else
            raise "bad stuff: #{i1},#{j1}: #{@matrix[i1][j1].inspect}"
          end
        end
      end
    end
    puts self
    puts new_positions
    new_positions
  end

  def to_s
    @matrix.map{|row| row.map{|c| "%4s" % unconvert_pos(c)}.join}.join("\n")
  end
  
  def find_starts
    starts = []
    @matrix.each_with_index{|r, i| r.each_with_index{|c, j| starts << [i, j] if c == :start}}
    starts
  end

  def unconvert_pos(c)
    case c
    when false
      "#"
    when 0 
      "A"
    when Integer
      c.to_s
    when :end
      "B"
    when true
      " "
    else
      raise "bad character: #{c}"
    end
  end

  def convert_pos(c)
    case c
    when "#"
      false
    when " "
      true
    when "A"
      :start
    when "B"
      :end
    else
      raise "bad character: #{c}"
    end
  end
end
