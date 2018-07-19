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
    assert_equal 1, board.translate_letter_to_column("B")
    assert_equal 25, board.translate_letter_to_column("Z")
  end

  def test_it_can_get_columns
    board = Board.new(7, 6)
    assert_equal ["A","B","C","D","E","F","G"], board.get_columns
  end

  def test_it_can_get_column_header
    board = Board.new(7, 6)
    assert_equal "ABCDEFG\n", board.get_column_header
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

  def test_it_can_place_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "B")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "B")
    assert_equal piece_1, board.grid[1][0].piece
    assert_equal piece_2, board.grid[1][1].piece
  end

  def test_it_return_true_upon_successfully_placing_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    assert_equal true, board.place_piece(piece_1, "B")
  end

  def test_it_returns_false_when_the_selected_column_is_full
    board = Board.new(1,1)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:O)
    assert_equal true, board.place_piece(piece_1, "A")
    assert_equal false, board.place_piece(piece_2, "A")
  end

  def test_it_can_get_column_headers
    board = Board.new(7, 6)
    assert_equal "ABCDEFG\n", board.get_column_header
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

  def test_it_can_find_coordinates_of_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "C")
    assert_equal ({column: 2, row: 0}), board.find_piece_coordinates(piece_1)
  end

  def test_it_can_find_space_of_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "C")
    assert_equal board.grid[2][0], board.find_piece_space(piece_1)
  end

  def test_it_can_get_row_index_of_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "C")
    assert_equal 0, board.get_row_index(piece_1)
  end

  def test_it_can_get_column_index_of_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "C")
    assert_equal 2, board.get_column_index(piece_1)
  end

  def test_it_can_get_northeast_index_of_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    board.place_piece(piece_1, "F")
    board.place_piece(piece_2, "F")
    board.place_piece(piece_3, "F")
    assert_equal 2, board.get_northeast_index(piece_3)
  end

  def test_it_can_get_northwest_index_of_a_piece
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    board.place_piece(piece_1, "F")
    board.place_piece(piece_2, "F")
    board.place_piece(piece_3, "F")
    assert_equal 1, board.get_northwest_index(piece_3)
  end

  def test_it_can_get_a_column
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "B")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "B")
    row = board.get_column(piece_1)
    assert_equal piece_1, row[0].piece
    assert_equal piece_2, row[1].piece
    assert row[2].empty?
  end

  def test_it_can_get_a_row
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    board.place_piece(piece_1, "B")
    piece_2 = Piece.new(:O)
    board.place_piece(piece_2, "C")
    row = board.get_row(piece_1)
    assert_equal piece_1, row[1].piece
    assert_equal piece_2, row[2].piece
    assert row[0].empty?
  end

  def test_it_can_traverse_diagonally
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    piece_4 = Piece.new(:X)
    board.place_piece(piece_1, "E")
    board.place_piece(piece_2, "F")
    board.place_piece(piece_3, "F")
    board.place_piece(piece_4, "G")
    northeast = board.traverse_diagonally(piece_3, :up, :right)
    assert_equal 1, northeast.length
    assert northeast[0].empty?
    southwest = board.traverse_diagonally(piece_3, :down, :left)
    assert_equal 1, southwest.length
    assert_equal piece_1, southwest[0].piece
    northwest = board.traverse_diagonally(piece_3, :up, :left)
    assert_equal 4, northwest.length
    assert northwest[0].empty?
    southeast = board.traverse_diagonally(piece_3, :down, :right)
    assert_equal 1, southeast.length
    assert_equal piece_4, southeast[0].piece
  end

  def test_it_can_get_northeast_diagonal
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    board.place_piece(piece_1, "E")
    board.place_piece(piece_2, "F")
    board.place_piece(piece_3, "F")
    diagonal = board.get_northeast_diagonal(piece_3)
    assert_equal piece_1, diagonal[0].piece
    assert_equal piece_3, diagonal[1].piece
    assert diagonal[2].empty?
    assert_equal 3, diagonal.length
  end

  def test_it_can_get_northwest_diagonal
    board = Board.new(7, 6)
    piece_1 = Piece.new(:X)
    piece_2 = Piece.new(:X)
    piece_3 = Piece.new(:X)
    board.place_piece(piece_1, "E")
    board.place_piece(piece_2, "F")
    board.place_piece(piece_3, "F")
    diagonal = board.get_northwest_diagonal(piece_3)
    assert_equal 6, diagonal.length
    assert_equal piece_3, diagonal[1].piece
    assert diagonal[0].empty?
    assert diagonal[2].empty?
  end
end
