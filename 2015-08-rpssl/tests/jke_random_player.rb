require_relative '../players/jke_random_player.rb'
require 'minitest/spec'
require 'minitest/autorun'

describe JkeRandomPlayer do
  it "#choose should work" do
    p = JkeRandomPlayer.new('jke')
    [:rock, :paper, :scissors, :lizard, :spock].include?(p.choose).must_equal true
  end
end
