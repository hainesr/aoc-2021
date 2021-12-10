# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/smoke_basin'

class AOC2021::SmokeBasinTest < MiniTest::Test
  MAP = <<~EOM
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
  EOM

  def setup
    @sb = AOC2021::SmokeBasin.new
    @sb.setup(MAP)
    @map = AOC2021::SmokeBasin::Map.new(MAP)
  end

  def test_build_map
    assert_equal(
      { [0, 1] => 1, [0, 9] => 0, [2, 2] => 5, [4, 6] => 5 },
      @map.low_points
    )
  end

  def test_part1
    assert_equal(15, @sb.part1)
  end

  def test_explore_basin
    assert_equal(
      [[0, 1], [0, 0], [1, 0]],
      @map.explore_basin([0, 1])
    )

    assert_equal(
      [
        [4, 6], [3, 6], [3, 7], [2, 7], [4, 7], [4, 8], [3, 8], [4, 9], [4, 5]
      ],
      @map.explore_basin([4, 6])
    )
  end

  def test_basin_sizes
    assert_equal([3, 9, 14, 9], @map.basin_sizes)
  end

  def test_part2
    assert_equal(1134, @sb.part2)
  end
end
