# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/treachery_of_whales'

class AOC2021::TreacheryOfWhalesTest < MiniTest::Test
  CRABS = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14].freeze

  def setup
    @tw = AOC2021::TreacheryOfWhales.new
  end

  def test_median
    assert_equal(0.5, @tw.median([0, 1]))
    assert_equal(1, @tw.median([0, 1, 2]))
    assert_equal(2, @tw.median(CRABS))
  end

  def test_fuel_calculator
    assert_equal(37, @tw.fuel_calculator(CRABS))
  end

  def test_fuel_calculator_max
    assert_equal(168, @tw.fuel_calculator_max(CRABS))
  end
end
