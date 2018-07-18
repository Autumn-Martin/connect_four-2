require 'minitest/autorun'
require 'minitest/pride'
require './lib/space'
require './lib/piece'

class SpaceTest < Minitest::Test
  def test_it_exists
    space = Space.new
    assert_instance_of Space, space
  end

  def test_its_piece_is_nil_by_default
    space = Space.new
    assert_nil space.piece
  end

  def test_it_can_be_filled
    piece = Piece.new(:X)
    space = Space.new
    space.fill(piece)
    assert_equal piece, space.piece
  end

  def test_it_knows_if_its_empty
    space = Space.new
    assert_equal true, space.empty?
    piece = Piece.new(:X)
    space.fill(piece)
    assert_equal false, space.empty?
  end

  def test_it_can_be_converted_to_string
    space = Space.new
    assert_equal ".", space.to_s
    piece = Piece.new(:X)
    space.fill(piece)
    assert_equal "X", space.to_s
    piece = Piece.new(:O)
    space.fill(piece)
    assert_equal "O", space.to_s
  end
end
