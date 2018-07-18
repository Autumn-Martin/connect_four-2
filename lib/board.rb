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

  def get_column_index(letter)
    letter.ord - 65
  end

  def place_piece(piece, column)
    column_index = get_column_index(column)
    space = @grid[column_index].find do |space|
      space.empty?
    end
    space.fill(piece)
  end

  def get_column_headers
    ending_num = "A".ord + @grid.length - 1
    ending_char = ending_num.chr
    characters = ("A"..ending_char).to_a
    characters << "\n"
    return characters.join
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

  def render
    rendered_rows = rows_top_to_bottom.map do |row|
      render_row(row)
    end
    rendered_rows.unshift(get_column_headers)
    rendered_rows.join
  end
end
