require './lib/board'
require './lib/piece'

class ConnectFour
  attr_reader :board, :win_number

  def initialize(length, height, win_number = 4)
    @board = Board.new(length, height)
    @win_number = win_number
  end

  def random_column
    length = @board.grid.length
    ending_char_ord = "A".ord + length - 1
    ending_char = ending_char_ord.chr
    characters = ("A"..ending_char).to_a
    characters.sample
  end

  def take_player_turn(column)
    piece = Piece.new(:X)
    success = @board.place_piece(piece, column)
    return piece if success
    return false
  end

  def take_computer_turn(column = random_column)
    piece = Piece.new(:O)
    success = @board.place_piece(piece, column)
    return piece if success
    return take_computer_turn
  end

  def check_for_win_state(piece)
    return true if check_vertical_win(piece)
    return true if check_horizontal_win(piece)
    return true if check_diagonal_win(piece)
    return false
  end

  def check_vertical_win(piece)
    column = @board.get_column(piece)
    piece_index = @board.get_row_index(piece)
    piece_type = piece.to_s
    return check_spaces_for_win(column, piece_type, piece_index)
  end

  def check_horizontal_win(piece)
    row = @board.get_row(piece)
    piece_index = @board.get_column_index(piece)
    piece_type = piece.to_s
    return check_spaces_for_win(row, piece_type, piece_index)
  end

  def check_diagonal_win(piece)
    northwest = @board.get_northwest_diagonal(piece)
    piece_index = @board.get_northwest_index(piece)
    piece_type = piece.to_s
    return true if check_spaces_for_win(northwest, piece_type, piece_index)
    northeast = @board.get_northeast_diagonal(piece)
    piece_index = @board.get_northeast_index(piece)
    return check_spaces_for_win(northeast, piece_type, piece_index)
  end

  def check_for_draw
    @board.grid.all? do |column|
      column.all? do |space|
        !space.empty?
      end
    end
  end

  def check_spaces_for_win(spaces, piece_type, piece_index)
    consecutive = 1
    consecutive += check_spaces_in_direction(spaces, piece_type, piece_index, -1)
    consecutive += check_spaces_in_direction(spaces, piece_type, piece_index, 1)
    return consecutive >= @win_number
  end

  def check_spaces_in_direction(spaces, piece_type, piece_index, direction)
    bounds = (0..spaces.length - 1)
    consecutive = 0
    index = piece_index + direction
    loop do
      return consecutive if !bounds.include?(index)
      return consecutive if spaces[index].to_s != piece_type
      consecutive += 1
      index += direction
    end
  end
end
