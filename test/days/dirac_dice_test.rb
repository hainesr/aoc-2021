# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/dirac_dice'

class AOC2021::DiracDiceTest < MiniTest::Test
  def setup
    @dd = ::AOC2021::DiracDice.new
  end

  def test_part1
    assert_equal(739_785, @dd.part1(4, 8))
  end
end
