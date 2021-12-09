# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/smoke_basin'

class AOC2021::SmokeBasinTest < MiniTest::Test
  MAP = <<~EOM.split("\n").map { |line| line.chars.map(&:to_i) }
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
  EOM

  def setup
    @sb = AOC2021::SmokeBasin.new
  end

  def test_find_low_points
    assert_equal(
      { [0, 1] => 1, [0, 9] => 0, [2, 2] => 5, [4, 6] => 5 },
      @sb.find_low_points(MAP)
    )
  end

  def test_risk_level
    assert_equal(15, @sb.risk_level(MAP))
  end
end
