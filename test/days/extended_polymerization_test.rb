# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/extended_polymerization'

class AOC2021::ExtendedPolymerizationTest < MiniTest::Test
  INPUT = <<~EOI.split("\n\n")
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
  EOI

  def setup
    @ep = AOC2021::ExtendedPolymerization.new
    @template, @pairs, @insertions = @ep.read_input(INPUT)
  end

  def test_read_input
    assert_equal(
      [
        'NNCB',
        {
          ['N', 'N'] => 1, ['N', 'C'] => 1, ['C', 'B'] => 1
        },
        {
          ['C', 'H'] => 'B', ['H', 'H'] => 'N', ['C', 'B'] => 'H',
          ['N', 'H'] => 'C', ['H', 'B'] => 'C', ['H', 'C'] => 'B',
          ['H', 'N'] => 'C', ['N', 'N'] => 'C', ['B', 'H'] => 'H',
          ['N', 'C'] => 'B', ['N', 'B'] => 'B', ['B', 'N'] => 'B',
          ['B', 'B'] => 'N', ['B', 'C'] => 'B', ['C', 'C'] => 'N',
          ['C', 'N'] => 'C'
        }
      ],
      [@template, @pairs, @insertions]
    )
  end

  def test_insert
    pairs = @ep.insert(@pairs, @insertions)

    %w[
      NCNBCHB NBCCNBBBCBHCB NBBBCNCCNBBNBNBBCHBHHBCHB
    ].map { |poly| poly.chars.each_cons(2).tally }.each do |poly|
      assert_equal(poly, pairs)
      pairs = @ep.insert(pairs, @insertions)
    end
  end

  def test_count_letters
    %w[
      NNCB NCNBCHB NBCCNBBBCBHCB NBBBCNCCNBBNBNBBCHBHHBCHB
    ].map(&:chars).each do |poly|
      assert_equal(
        poly.tally, @ep.count_letters(@template, poly.each_cons(2).tally)
      )
    end
  end

  def test_part1
    assert_equal(1588, @ep.part1(@template, @pairs, @insertions))
  end
end
