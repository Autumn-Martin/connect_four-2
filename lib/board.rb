require './lib/space'

class Board
  attr_reader :grid

  def initialize(length, height)
    @grid = make_grid(length, height)
  end

  def make_grid(length, height)
    grid = []
    length.times do
      row = []
      height.times do
        row << Space.new
      end
      grid << row
    end
    return grid
  end

  def translate_letter_to_column(letter)
    letter.ord - 65
  end

  def validate_column(column)
    length = @grid.length
    ending_char_ord = "A".ord + length - 1
    ending_char = ending_char_ord.chr
    characters = ("A"..ending_char).to_a
    characters.sample

  end

  def place_piece(piece, column)
    column_index = translate_letter_to_column(column)
    space = @grid[column_index].find do |space|
      space.empty?
    end
    return false if space == nil
    space.fill(piece)
    return true
  end

  def get_columns
    ending_num = "A".ord + @grid.length - 1
    ending_char = ending_num.chr
    characters = ("A"..ending_char).to_a
  end

  def get_column_header
    characters = get_columns
    characters << "\n"
    return characters.join
  end

  def find_piece_coordinates(piece)
    @grid.each.with_index do |column, column_index|
      column.each.with_index do |space, row_index|
        if space.piece == piece
          return {column: column_index, row: row_index}
        end
      end
    end
  end

  def find_piece_space(piece)
    coordinates = find_piece_coordinates(piece)
    return @grid[coordinates[:column]][coordinates[:row]]
  end

  def get_column(piece)
    @grid[get_column_index(piece)]
  end

  def get_row(piece)
    @grid.transpose[get_row_index(piece)]
  end

  def get_column_index(piece)
    return find_piece_coordinates(piece)[:column]
  end

  def get_row_index(piece)
    return find_piece_coordinates(piece)[:row]
  end

  def get_northeast_index(piece)
    southwest = traverse_diagonally(piece, :down, :left)
    return southwest.length
  end

  def get_northwest_index(piece)
    southeast = traverse_diagonally(piece, :down, :right)
    return southeast.length
  end

  def get_northeast_diagonal(piece)
    southwest = traverse_diagonally(piece, :down, :left)
    spaces = southwest.reverse
    spaces += [find_piece_space(piece)]
    northeast = traverse_diagonally(piece, :up, :right)
    spaces += northeast
    return spaces
  end

  def get_northwest_diagonal(piece)
    southeast = traverse_diagonally(piece, :down, :right)
    spaces = southeast.reverse
    spaces += [find_piece_space(piece)]
    northwest = traverse_diagonally(piece, :up, :left)
    spaces += northwest
    return spaces
  end

  def traverse_diagonally(piece, vertical_direction, horizontal_direction)
    if vertical_direction == :up
      vertical_modifier = 1
      vertical_bound = @grid[0].length
    else
      vertical_modifier = -1
      vertical_bound = -1
    end
    if horizontal_direction == :right
      horizontal_modifier = 1
      horizontal_bound = @grid.length
    else
      horizontal_modifier = -1
      horizontal_bound = -1
    end
    column = get_column_index(piece) + horizontal_modifier
    row = get_row_index(piece) + vertical_modifier
    spaces = []
    while row != vertical_bound && column != horizontal_bound
      spaces << @grid[column][row]
      column += horizontal_modifier
      row += vertical_modifier
    end
    return spaces
  end

  def render_row(row)
    characters = row.map do |space|
      space.to_s
    end
    characters << "\n"
    characters.join
  end

  def rows_top_to_bottom
    @grid.transpose.reverse
  end

  def rows_bottom_to_top
    rows_top_to_bottom.reverse
  end

  def render
    rendered_rows = rows_top_to_bottom.map do |row|
      render_row(row)
    end
    rendered_rows.unshift(get_column_header)
    rendered_rows.join
  end
end
