# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/trench_map'

class AOC2021::TrenchMapTest < MiniTest::Test
  INPUT = <<~EOI.split("\n\n")
    ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

    #..#.
    #....
    ##..#
    ..#..
    ..###
  EOI

  def setup
    @tm = ::AOC2021::TrenchMap.new
  end

  def test_parse_input
    alg, input = @tm.parse_input(INPUT)
    assert_kind_of(Array, alg)
    assert_equal(512, alg.length)
    assert_kind_of(Hash, input)
    assert_equal(25, input.size)
  end

  def test_enhance
    alg, input = @tm.parse_input(INPUT)

    image = @tm.enhance(input, alg, swap_void: false)
    assert_equal(24, image.values.sum)

    image = @tm.enhance(image, alg, swap_void: false)
    assert_equal(35, image.values.sum)
  end
end
