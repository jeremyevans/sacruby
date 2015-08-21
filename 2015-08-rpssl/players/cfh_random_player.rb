class CfhRandomPlayer < Player
  MOVES = [:spock, :rock, :paper, :scissors, :lizard, :spock]

  def initialize(name)
    super
  end

  def choose
    MOVES.sample
  end
end
