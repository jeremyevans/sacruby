require 'test/unit'
require 'maze'

MAZE1 = %{#####################################
# #   #     #A        #     #       #
# # # # # # ####### # ### # ####### #
# # #   # #         #     # #       #
# ##### # ################# # #######
#     # #       #   #     # #   #   #
##### ##### ### ### # ### # # # # # #
#   #     #   # #   #  B# # # #   # #
# # ##### ##### # # ### # # ####### #
# #     # #   # # #   # # # #       #
# ### ### # # # # ##### # # # ##### #
#   #       #   #       #     #     #
#####################################}
# Maze 1 should SUCCEED

MAZE2 = %{#####################################
# #       #             #     #     #
# ### ### # ########### ### # ##### #
# #   # #   #   #   #   #   #       #
# # ###A##### # # # # ### ###########
#   #   #     #   # # #   #         #
####### # ### ####### # ### ####### #
#       # #   #       # #       #   #
# ####### # # # ####### # ##### # # #
#       # # # #   #       #   # # # #
# ##### # # ##### ######### # ### # #
#     #   #                 #     #B#
#####################################}
# Maze 2 should SUCCEED

MAZE3 = %{#####################################
# #   #           #                 #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #  A  #   #       #   # #
# ######### ##### # ####### ### ### #
#               ###       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #   #           #
#####################################}
# Maze 3 should FAIL

MAZE4 = %{#####################################
# #   #           #                A#
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #     #   #       #   # #
# ######### ##### # ####### ### ### #
#               # #       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #               #
#####################################}
# Maze 4 should SUCCEED

MAZE5 = %{#####################################
#A #   #           #                #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #  A  #   #       #   # #
# ######### ##### # ####### ### ### #
#               # #       # # # #   #
# ### ### ############### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### #### # ### # #####  #
#   #         #     #   #           #
#####################################}
# Maze 5 should FAIL

MAZE6 = %{#####################################
#B#   #           #                 #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #     #   #       #   # #
# ######### ##### # ####### ### ### #
#               # #       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     # #   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #              A#
#####################################}
# Maze 6 should SUCCEED

class MazeTest < Test::Unit::TestCase
  def test_good_mazes
     assert_equal true, Maze.new(MAZE1).solvable?
     assert_equal true, Maze.new(MAZE2).solvable?
  end
  def test_good_mazes2
      assert_equal true, Maze.new(MAZE4).solvable?
      assert_equal true, Maze.new(MAZE6).solvable?
  end
 
  def test_bad_mazes
    assert_equal false, Maze.new(MAZE3).solvable?
  end

  def test_bad_mazes_multistart
    assert_equal false, Maze.new(MAZE5).solvable?
  end

  def test_maze_steps
    assert_equal 44, Maze.new(MAZE1).steps
    assert_equal 75, Maze.new(MAZE2).steps
    assert_equal 48, Maze.new(MAZE4).steps
    assert_equal 52, Maze.new(MAZE6).steps
  end
  
  def test_maze_steps_bad
    assert_equal 0, Maze.new(MAZE3).steps
    assert_equal 0, Maze.new(MAZE5).steps
  end
  
end
