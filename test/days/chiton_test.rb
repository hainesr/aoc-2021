# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/chiton'

class AOC2021::ChitonTest < MiniTest::Test
  INPUT = <<~EOI.split("\n")
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
  EOI

  def setup
    @c = AOC2021::Chiton.new
  end

  def test_read_grid
    grid = @c.read_grid(INPUT)
    assert_equal(1, grid[[0, 0]])
    assert_equal(1, grid[[9, 9]])
    assert_equal(7, grid[[6, 4]])
  end

  def test_calculate_risk
    grid = @c.read_grid(INPUT)
    @c.calculate_risk(grid)
    assert_equal(40, grid[[9, 9]])
  end
end
