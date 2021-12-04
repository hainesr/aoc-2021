# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/giant_squid'

class AOC2021::GiantSquidTest < MiniTest::Test
  BINGO = <<~EOB
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
  EOB

  def setup
    @gs = ::AOC2021::GiantSquid.new
  end

  def test_move
    numbers, boards = @gs.read_boards(BINGO)

    # A number that's not in the boards.
    boards = @gs.move(boards, 999)
    assert_equal(0, boards.flatten.count(nil))

    (1..5).each do |i|
      boards = @gs.move(boards, numbers.shift)
      assert_equal(i * 3, boards.flatten.count(nil))
    end

    # 7 again, just to be sure.
    boards = @gs.move(boards, 7)
    assert_equal(15, boards.flatten.count(nil))

    # 1 is only in one board.
    boards = @gs.move(boards, 1)
    assert_equal(16, boards.flatten.count(nil))

    # Again, a number that's not in the boards.
    boards = @gs.move(boards, 999)
    assert_equal(16, boards.flatten.count(nil))
  end

  def test_won?
    _, boards = @gs.read_boards(BINGO)

    boards.each do |board|
      refute(@gs.won?(board))
    end

    boards[0][3] = [nil] * 5
    assert(@gs.won?(boards[0]))

    boards[1] = [[0, nil, 2, 3, 4]] * 5
    assert(@gs.won?(boards[1]))
  end

  def test_play
    numbers, boards = @gs.read_boards(BINGO)

    assert_equal(
      [24, [10, 16, 15, 19, 18, 8, 26, 20, 22, 13, 6, 12, 3]],
      @gs.play(boards, numbers)
    )
  end
end
