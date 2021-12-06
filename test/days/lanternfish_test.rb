# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/lanternfish'

class AOC2021::LanternfishTest < MiniTest::Test
  FISH = '3,4,3,1,2'

  def setup
    @l = AOC2021::Lanternfish.new
  end

  def test_days_one_at_a_time
    fish = @l.tally_fish(FISH)

    assert_equal([1, 1, 2, 1, 0, 0, 0, 0, 0], @l.days(fish))
    assert_equal([1, 2, 1, 0, 0, 0, 1, 0, 1], @l.days(fish))
  end

  def test_days_part1
    fish = @l.tally_fish(FISH)
    fish = @l.days(fish, days: 80)

    assert_equal(5934, fish.sum)
  end

  def test_days_part2
    fish = @l.tally_fish(FISH)
    fish = @l.days(fish, days: 256)

    assert_equal(26_984_457_539, fish.sum)
  end

  def test_tally_fish
    assert_equal([0, 1, 1, 2, 1, 0, 0, 0, 0], @l.tally_fish(FISH))
  end
end
