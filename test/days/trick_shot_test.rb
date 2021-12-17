# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/trick_shot'

class AOC2021::TrickShotTest < MiniTest::Test
  TARGET = [(20..30), (-10..-5)].freeze

  def setup
    @ts = AOC2021::TrickShot.new
  end

  def test_part1
    assert_equal(45, @ts.part1(TARGET))
  end
end
