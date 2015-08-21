require_relative '../players/cfh_lizard_player.rb'
require 'test/unit'

class MyPlayerTest < Test::Unit::TestCase

    def test_choose_rock
      p = CfhLizardPlayer.new('cfh')
      assert_equal(p.choose, :lizard)
    end
end
