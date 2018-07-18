require 'minitest/pride'
require 'minitest/autorun'
require './lib/board'
require './lib/piece'
require 'pry'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new(7, 6)
    assert_instance_of Board, board
  end

  def test_it_can_make_a_grid
    board = Board.new(7, 6)
    grid = board.make_grid(7, 6)
    assert_equal 7, grid.length
    assert_equal 6, grid[0].length
    assert_instance_of Space, grid[0][0]
    assert_nil grid[0][0].piece
  end

  def test_it_has_grid_with_correct_dimensions
    board = Board.new(7, 6)
    assert_equal 7, board.grid.length
    assert_equal 6, board.grid[0].length
  end

  def test_its_grid_is_filled_with_empty_spaces
    board = Board.new(7, 6)
    assert_instance_of Space, board.grid[0][0]
    assert_nil board.grid[0][0].piece
  end

  def test_it_can_get_column_index_from_a_letter
    board = Board.new(7, 6)
    assert_equal 1, board.get_column_index("B")
    assert_equal 25, board.get_column_index("Z")
  end

  def test_it_can_place_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "B")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "B")
    assert_equal piece_1, board.grid[1][0].piece
    assert_equal piece_2, board.grid[1][1].piece
  end

  def test_it_can_get_column_headers
    board = Board.new(7, 6)
    assert_equal "ABCDEFG\n", board.get_column_headers
  end

  def test_it_can_render_a_row
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    space_1 = Space.new
    space_1.fill(piece_1)
    piece_2 = Piece.new(:O)
    space_2 = Space.new
    space_2.fill(piece_2)
    row =[Space.new, space_1, Space.new, space_2, Space.new]

    expected = ".X.O.\n"
    assert_equal expected, board.render_row(row)
  end

  def test_it_can_get_the_board_by_rows_from_top_to_bottom
    board = Board.new(2, 3)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "A")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "A")
    assert_equal piece_2, board.rows_top_to_bottom[1][0].piece
    assert_equal piece_1, board.rows_top_to_bottom[2][0].piece
  end

  def test_it_can_render_the_board
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "B")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "B")
    expected =  "ABCDEFG\n" +
                ".......\n" +
                ".......\n" +
                ".......\n" +
                ".......\n" +
                ".O.....\n" +
                ".X.....\n"

    assert_equal expected, board.render
  end
end
