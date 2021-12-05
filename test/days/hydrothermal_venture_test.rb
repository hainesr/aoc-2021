# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/hydrothermal_venture'

class AOC2021::HydrothermalVentureTest < MiniTest::Test
  COORDS = <<~EOC.split("\n")
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
  EOC

  PARSED_COORDS = [
    [true, [[0, 9], [1, 9], [2, 9], [3, 9], [4, 9], [5, 9]]],
    [false, [
      [8, 0], [7, 1], [6, 2], [5, 3], [4, 4], [3, 5], [2, 6], [1, 7], [0, 8]
    ]],
    [true, [[9, 4], [8, 4], [7, 4], [6, 4], [5, 4], [4, 4], [3, 4]]],
    [true, [[2, 2], [2, 1]]],
    [true, [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4]]],
    [false, [[6, 4], [5, 3], [4, 2], [3, 1], [2, 0]]],
    [true, [[0, 9], [1, 9], [2, 9]]],
    [true, [[3, 4], [2, 4], [1, 4]]],
    [false, [
      [0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]
    ]],
    [false, [[5, 5], [6, 4], [7, 3], [8, 2]]]
  ].freeze

  def setup
    @hv = AOC2021::HydrothermalVenture.new
  end

  def test_read_coords
    assert_equal(PARSED_COORDS, @hv.read_coords(COORDS))
  end

  def test_map_overlaps
    overlaps = @hv.map_overlaps(PARSED_COORDS)
    assert_equal(5, overlaps.count { |_, v| v > 1 })

    overlaps = @hv.map_overlaps(PARSED_COORDS, aligned_only: false)
    assert_equal(12, overlaps.count { |_, v| v > 1 })
  end
end
