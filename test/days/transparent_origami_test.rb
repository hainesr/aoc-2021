# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/transparent_origami'

class AOC2021::TransparentOrigamiTest < MiniTest::Test
  INPUT = <<~EOI.split("\n\n")
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
  EOI

  def setup
    @to = AOC2021::TransparentOrigami.new
  end

  def test_parse_input
    assert_equal(
      [
        [
          [6, 10], [0, 14], [9, 10], [0, 3], [10, 4], [4, 11], [6, 0],
          [6, 12], [4, 1], [0, 13], [10, 12], [3, 4], [3, 0], [8, 4],
          [1, 10], [2, 14], [8, 10], [9, 0]
        ],
        [[1, 7], [0, 5]]
      ],
      @to.parse_input(INPUT)
    )
  end

  def test_fold
    dots, folds = @to.parse_input(INPUT)

    dots = @to.fold(folds[0], dots)
    assert_equal(17, dots.length)

    dots = @to.fold(folds[1], dots)
    assert_equal(16, dots.length)
  end
end
