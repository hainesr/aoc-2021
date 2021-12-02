# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/dive'

class AOC2021::DiveTest < MiniTest::Test
  COURSE = <<~EOC
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  EOC

  def setup
    @d = AOC2021::Dive.new
    @directions = @d.read_directions(COURSE)
  end

  def test_find_destination_coords
    assert_equal([15, 10], @d.find_destination_coords(@directions))
  end

  def test_find_destination_coords_aim
    assert_equal([15, 60], @d.find_destination_coords_aim(@directions))
  end

  def test_read_directions
    assert_equal(
      [
        [:forward, 5],
        [:down, 5],
        [:forward, 8],
        [:up, 3],
        [:down, 8],
        [:forward, 2]
      ],
      @d.read_directions(COURSE)
    )
  end
end
