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

  def test_quantum_dice
    wins = @dd.quantum_dice(4, 0, 0, 8, 0, 0, 1)
    assert_equal(444_356_092_776_315, wins.max)
  end
end
