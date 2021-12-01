# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/sonar_sweep'

class AOC2021::SonarSweepTest < MiniTest::Test
  REPORT = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263].freeze

  def setup
    @ss = AOC2021::SonarSweep.new
  end

  def test_count_increments
    assert_equal(7, @ss.count_increments(REPORT))
  end
end
