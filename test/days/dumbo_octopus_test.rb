# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/dumbo_octopus'

class AOC2021::DumboOctopusTest < MiniTest::Test
  INPUT = <<~EOI
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
  EOI

  def setup
    @do = AOC2021::DumboOctopus.new
  end

  def test_build_grid
    grid = @do.build_grid(INPUT)

    assert_equal(5, grid[[0, 0]])
    assert_equal(6, grid[[9, 9]])
    assert_equal(8, grid[[5, 4]])
  end

  def test_neighbours_for
    assert_equal(
      [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]],
      @do.neighbours_for([1, 1])
    )

    assert_equal(
      [[0, 1], [1, 0], [1, 1]],
      @do.neighbours_for([0, 0])
    )

    assert_equal(
      [[8, 8], [8, 9], [9, 8]],
      @do.neighbours_for([9, 9])
    )
  end

  def test_step
    grid = @do.build_grid(INPUT)

    assert_equal([], @do.step(grid))
    assert_equal(35, @do.step(grid).length)
    assert_equal(45, @do.step(grid).length)
  end

  def test_part1
    grid = @do.build_grid(INPUT)

    assert_equal(204, @do.part1(grid.dup, 10))
    assert_equal(1656, @do.part1(grid))
  end
end
