class JkeRandomPlayer < Player
  CHOICES = [:rock, :paper, :scissors, :lizard, :spock].freeze

  def choose
    CHOICES.sample
  end
end
