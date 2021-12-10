# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/syntax_scoring'

class AOC2021::SyntaxScoringTest < MiniTest::Test
  INPUT = <<~EOI.split("\n")
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
  EOI

  def setup
    @ss = AOC2021::SyntaxScoring.new
  end

  def test_find_line_error
    assert_equal(']', @ss.find_line_error('(]'))
    assert_equal('>', @ss.find_line_error('{()()()>'))
    assert_equal('}', @ss.find_line_error('(((()))}'))
    assert_equal(')', @ss.find_line_error('<([]){()}[{}])'))
    assert_nil(@ss.find_line_error('[({(<(())[]>[[{[]{<()<>>'))
  end

  def test_scores
    assert_equal([57], @ss.scores(['(]']))
    assert_equal([25_137], @ss.scores(['{()()()>']))
    assert_equal([1197, 3, 57, 3, 25_137], @ss.scores(INPUT))
  end
end
