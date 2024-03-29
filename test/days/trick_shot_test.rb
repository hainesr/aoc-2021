# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/trick_shot'

class AOC2021::TrickShotTest < MiniTest::Test
  TARGET = {
    x: (20..30),
    y: (-10..-5)
  }.freeze

  def setup
    @ts = AOC2021::TrickShot.new
  end

  def test_part1
    assert_equal(45, @ts.part1(TARGET))
  end

  def test_sim
    assert_equal(112, @ts.sim(TARGET).length)
  end
end
