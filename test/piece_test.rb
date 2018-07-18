require 'minitest/autorun'
require 'minitest/pride'
require './lib/piece'

class PieceTest < Minitest::Test
  def test_it_exists
    piece = Piece.new(:X)
  end

  def test_it_can_call_to_s
    piece = Piece.new(:X)
    assert_equal "X", piece.to_s
  end
end
