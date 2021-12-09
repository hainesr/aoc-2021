# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/seven_segment_search'

class AOC2021::SevenSegmentSearchTest < MiniTest::Test
  RAW_INPUT = <<~EOI
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  EOI

  INPUT = RAW_INPUT.split("\n").map do |line|
    line.split(' | ').map do |seq|
      seq.split.map { |num| num.chars.sort }
    end
  end

  SIGNALS = %w[
    acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab
  ].map { |num| num.chars.sort }

  OUTPUT = %w[cdfeb fcadb cdfeb cdbaf].map { |num| num.chars.sort }

  def setup
    @sss = AOC2021::SevenSegmentSearch.new
  end

  def test_count_unique_outputs
    assert_equal(26, @sss.count_unique_outputs(INPUT))
  end

  def test_identify_numbers_for_line
    lookup = @sss.identify_numbers_for_line(SIGNALS)

    [8, 5, 2, 3, 7, 9, 6, 4, 0, 1].each_with_index do |n, i|
      assert_equal(n, lookup[SIGNALS[i]])
    end
  end

  def test_decode_line
    assert_equal([5, 3, 5, 3], @sss.decode_line([SIGNALS, OUTPUT]))
  end

  def test_decode
    assert_equal(61_229, @sss.decode(INPUT))
  end
end
