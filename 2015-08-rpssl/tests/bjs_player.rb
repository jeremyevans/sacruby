require_relative '../players/bjs_player.rb'
require_relative '../players/cfh_lizard_player.rb'
require 'test/unit'

class MyPlayerTest < Test::Unit::TestCase

  def test_choose_paper
    p = BjsPlayer.new('bjs')
    assert_equal(p.choose, :paper)
  end

  def test_opponents_choose_rock
    p = CfhLizardPlayer.new('cfh')
    assert_equal(p.new_choose, :rock)
  end
end
