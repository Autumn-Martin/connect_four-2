require 'minitest/autorun'
require 'minitest/pride'
require './lib/connect_four'
require 'pry'

class ConnectFourTest < Minitest::Test
  def test_it_exists
    connect_four = ConnectFour.new(7, 6)
    assert_instance_of ConnectFour, connect_four
  end

  def test_it_has_a_win_number
    connect_four = ConnectFour.new(7, 6)
    assert_equal 4, connect_four.win_number
  end

  def test_it_has_a_board
    connect_four = ConnectFour.new(7, 6)
    assert_instance_of Board, connect_four.board
    assert_equal 7, connect_four.board.grid.length
    assert_equal 6, connect_four.board.grid[0].length
  end

  def test_it_can_pick_a_random_column
    connect_four = ConnectFour.new(7, 6)
    column = connect_four.random_column
    assert ("A".."G").include? column
  end

  def test_it_can_take_a_valid_player_turn
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("A")
    refute connect_four.board.grid[0][0].empty?
  end

  def test_it_returns_placed_piece_upon_successful_player_turn
    connect_four = ConnectFour.new(7, 6)
    piece = connect_four.take_player_turn("A")
    assert_instance_of Piece, piece
  end

  def test_it_returns_false_upon_invalid_placement
    connect_four = ConnectFour.new(7, 6)
    6.times do
      connect_four.take_player_turn("A")
    end
    assert_equal false, connect_four.take_player_turn("A")
  end

  def test_it_takes_computer_turn
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_computer_turn("A")
    refute connect_four.board.grid[0][0].empty?
  end

  def test_it_returns_placed_piece_upon_successful_computer_turn
    connect_four = ConnectFour.new(7, 6)
    piece = connect_four.take_computer_turn("A")
    assert_instance_of Piece, piece
  end

  def test_it_will_retry_when_random_column_is_full
    connect_four = ConnectFour.new(7, 6)
    6.times do
      connect_four.take_player_turn("A")
    end
    connect_four.take_computer_turn("A")
    bottom_row = connect_four.board.rows_top_to_bottom[5]
    num_on_bottom = bottom_row.count do |space|
      !space.empty?
    end
    assert_equal 2, num_on_bottom
  end

  def test_it_can_check_spaces_in_a_direction
    connect_four = ConnectFour.new(7, 6)

    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    piece_4 = Piece.new(:X)
    piece_5 = Piece.new(:O)
    spaces = [Space.new.fill(piece_1), Space.new.fill(piece_2), Space.new.fill(piece_3),
              Space.new.fill(piece_4), Space.new.fill(piece_5), Space.new]
    assert_equal 2, connect_four.check_spaces_in_direction(spaces, "X", 2, -1)
    assert_equal 1, connect_four.check_spaces_in_direction(spaces, "X", 2, 1)
  end

  def test_it_can_check_spaces_for_a_win
    connect_four = ConnectFour.new(7, 6)

    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    piece_4 = Piece.new(:X)
    piece_5 = Piece.new(:O)
    spaces = [Space.new.fill(piece_1), Space.new.fill(piece_2), Space.new.fill(piece_3),
              Space.new.fill(piece_4), Space.new.fill(piece_5), Space.new]
    assert_equal false, connect_four.check_spaces_for_win(spaces, "O", 4)
    assert_equal true, connect_four.check_spaces_for_win(spaces, "X", 2)
  end

  def test_it_can_check_vertical_win_condition
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("E")
    connect_four.take_player_turn("E")
    piece = connect_four.take_player_turn("E")
    assert_equal false, connect_four.check_vertical_win(piece)
    piece = connect_four.take_player_turn("E")
    assert_equal true, connect_four.check_vertical_win(piece)
  end

  def test_it_can_check_horizontal_win_condition
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("B")
    connect_four.take_player_turn("D")
    piece = connect_four.take_player_turn("E")
    assert_equal false, connect_four.check_horizontal_win(piece)
    piece = connect_four.take_player_turn("C")
    assert_equal true, connect_four.check_horizontal_win(piece)
  end

  def test_it_can_check_diagonal_win_condition
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("B")
    connect_four.take_computer_turn("C")
    connect_four.take_player_turn("C")
    connect_four.take_computer_turn("D")
    connect_four.take_player_turn("D")
    connect_four.take_computer_turn("E")
    connect_four.take_player_turn("E")
    connect_four.take_computer_turn("E")
    connect_four.take_player_turn("E")
    piece = connect_four.take_computer_turn("F")
    assert_equal false, connect_four.check_diagonal_win(piece)
    piece = connect_four.take_player_turn("D")
    assert_equal true, connect_four.check_diagonal_win(piece)
  end

  def test_it_can_check_for_draw
    connect_four = ConnectFour.new(2, 2)
    connect_four.take_player_turn("A")
    connect_four.take_computer_turn("B")
    connect_four.take_player_turn("A")
    assert_equal false, connect_four.check_for_draw
    connect_four.take_computer_turn("B")
    assert_equal true, connect_four.check_for_draw
  end

  def test_check_for_win_state_when_game_is_won_vertically
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("B")
    connect_four.take_player_turn("B")
    connect_four.take_player_turn("B")
    piece = connect_four.take_player_turn("B")
    assert_equal true, connect_four.check_for_win_state(piece)
  end

  def test_check_for_win_state_when_game_is_won_horizontally
    connect_four = ConnectFour.new(7,6)
    connect_four.take_player_turn("A")
    connect_four.take_player_turn("C")
    connect_four.take_player_turn("D")
    piece = connect_four.take_player_turn("B")
    assert_equal true, connect_four.check_for_win_state(piece)
  end

  def test_check_for_win_state_when_game_is_won_northeast
    connect_four = ConnectFour.new(7,6)
    connect_four.take_player_turn("B")
    connect_four.take_computer_turn("C")
    connect_four.take_player_turn("C")
    connect_four.take_computer_turn("D")
    connect_four.take_player_turn("D")
    connect_four.take_computer_turn("E")
    connect_four.take_player_turn("E")
    connect_four.take_computer_turn("E")
    connect_four.take_player_turn("E")
    piece = connect_four.take_computer_turn("A")
    piece = connect_four.take_player_turn("D")
    assert_equal true, connect_four.check_for_win_state(piece)
  end

  def test_check_for_win_state_when_game_is_won_northwest
    connect_four = ConnectFour.new(7,6)
    connect_four.take_player_turn("A")
    connect_four.take_computer_turn("A")
    connect_four.take_player_turn("A")
    connect_four.take_computer_turn("B")
    connect_four.take_player_turn("A")
    connect_four.take_computer_turn("B")
    connect_four.take_player_turn("B")
    connect_four.take_computer_turn("C")
    connect_four.take_player_turn("C")
    connect_four.take_computer_turn("A")
    piece = connect_four.take_player_turn("D")
    assert_equal true, connect_four.check_for_win_state(piece)
  end

  def test_check_win_state
    skip
    connect_four = ConnectFour.new(7, 6)
    connect_four.take_player_turn("A")
    connect_four.take_player_turn("A")
    connect_four.take_player_turn("B")
    connect_four.take_computer_turn("A")
    connect_four.take_computer_turn("B")
    connect_four.take_computer_turn("C")
    connect_four.take_player_turn("A")
    connect_four.take_player_turn("B")
    connect_four.take_player_turn("C")
    piece = connect_four.take_player_turn("D")
    assert_equal true, connect_four.check_for_win_state(piece)
  end
end
