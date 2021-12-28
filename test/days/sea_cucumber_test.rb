# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/sea_cucumber'

class AOC2021::SeaCucumberTest < MiniTest::Test
  INPUT = <<~EOI.split("\n")
    v...>>.vv>
    .vv>>.vv..
    >>.>v>...v
    >>v>>.>.v.
    v>v.vv.v..
    >.>>..v...
    .vv..>.>v.
    v.v..>>v.v
    ....v..v.>
  EOI

  LINE = ['...>>>>>...'].freeze

  BLOCK = <<~EOB.split("\n")
    ..........
    .>v....v..
    .......>..
    ..........
  EOB

  def setup
    @sc = AOC2021::SeaCucumber.new
  end

  def test_read_map
    w, h, east, south = @sc.read_map(INPUT)

    assert_equal(10, w)
    assert_equal(9, h)
    assert_equal(23, east.size)
    assert_equal(26, south.size)
    assert(east.include?(89))
    refute(south.include?(89))
    assert(south.include?(0))
    refute(east.include?(0))
  end

  def test_step_line
    w, h, east, south = @sc.read_map(LINE)

    move, east, south = @sc.step(w, h, east, south)
    assert(move)
    assert(east.include?(8))
    refute(east.include?(7))

    move, east, _south = @sc.step(w, h, east, south)
    assert(move)
    assert(east.include?(7))
    assert(east.include?(9))
    refute(east.include?(8))
  end

  def test_step_block
    w, h, east, south = @sc.read_map(BLOCK)

    move, east, south = @sc.step(w, h, east, south)
    assert(move)
    assert(east.include?(11))
    assert(east.include?(28))
    assert(south.include?(22))
    assert(south.include?(27))
  end

  def test_part1
    w, h, east, south = @sc.read_map(INPUT)

    assert_equal(58, @sc.part1(w, h, east, south))
  end
end
