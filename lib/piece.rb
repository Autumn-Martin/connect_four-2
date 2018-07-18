class Piece
  def initialize(piece_type)
    @piece_type = piece_type
  end

  def to_s
    @piece_type.to_s
  end
end
