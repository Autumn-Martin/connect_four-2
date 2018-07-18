class Space
  attr_reader :piece

  def initialize
    @piece = nil
  end

  def fill(piece)
    @piece = piece
  end

  def empty?
    return @piece == nil
  end

  def to_s
    return "." if empty?
    return @piece.to_s
  end
end
