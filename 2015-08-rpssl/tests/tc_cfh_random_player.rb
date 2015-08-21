require_relative '../players/cfh_random_player.rb'
require 'test/unit'

class MyPlayerTest < Test::Unit::TestCase

    def test_choose_rock
      p = CfhRandomPlayer.new('cfh')
      choice = p.choose
      assert(
        [:spock, :rock, :paper, :scissors, :lizard].any? do |move|
          move == choice
        end
      )
    end
end
