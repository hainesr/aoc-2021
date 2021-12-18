# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/snailfish'

class AOC2021::SnailfishTest < MiniTest::Test
  LIST1_INPUT = <<~EOI1.split("\n")
    [1,1]
    [2,2]
    [3,3]
    [4,4]
  EOI1
  LIST1_RESULT = '[[[[1,1],[2,2]],[3,3]],[4,4]]'

  LIST2_INPUT = <<~EOI2.split("\n")
    [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
    [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
    [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
    [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
    [7,[5,[[3,8],[1,4]]]]
    [[2,[2,2]],[8,[8,1]]]
    [2,9]
    [1,[[[9,3],9],[[9,0],[0,7]]]]
    [[[5,[7,4]],7],1]
    [[[[4,2],2],6],[8,7]]
  EOI2
  LIST2_RESULT = '[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]'

  def setup
    @s = AOC2021::Snailfish.new
  end

  def test_parse
    assert_equal([[1, 3], [2, 3], [3, 2], [4, 1]], @s.parse('[[[1, 2], 3], 4]'))
    assert_equal([[1, 1], [2, 2], [3, 3], [4, 3]], @s.parse('[1, [2, [3, 4]]]'))
  end

  def test_split_index
    assert_equal(0, @s.split_index([[10, 1], [1, 1]]))
    assert_equal(1, @s.split_index([[1, 1], [11, 1]]))
    assert_nil(@s.split_index(@s.parse('[[[[[9,8],1],2],3],4]')))
  end

  def test_split!
    [
      [[[10, 1], [1, 1]], 0, [[5, 2], [5, 2], [1, 1]]],
      [[[1, 1], [11, 1]], 1, [[1, 1], [5, 2], [6, 2]]],
      [[[1, 1], [12, 1]], 1, [[1, 1], [6, 2], [6, 2]]],
      [[[1, 1], [2, 2], [10, 2]], 2, [[1, 1], [2, 2], [5, 3], [5, 3]]]
    ].each do |number, index, result|
      @s.split!(number, index)
      assert_equal(result, number)
    end
  end

  def test_explode_index
    assert_equal(0, @s.explode_index(@s.parse('[[[[[9,8],1],2],3],4]')))
    assert_equal(4, @s.explode_index(@s.parse('[7,[6,[5,[4,[3,2]]]]]')))
    assert_equal(3, @s.explode_index(@s.parse('[[6,[5,[4,[3,2]]]],1]')))
    assert_nil(@s.explode_index(@s.parse('[[[[0,9],2],3],4]')))
    assert_nil(@s.explode_index(@s.parse('[7,[6,[5,[7,0]]]]')))
  end

  def test_explode!
    [
      ['[[[[[9,8],1],2],3],4]', 0, '[[[[0,9],2],3],4]'],
      ['[7,[6,[5,[4,[3,2]]]]]', 4, '[7,[6,[5,[7,0]]]]'],
      ['[[6,[5,[4,[3,2]]]],1]', 3, '[[6,[5,[7,0]]],3]'],
      [
        '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]',
        3,
        '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]'
      ]
    ].each do |input, index, result|
      number = @s.parse(input)
      @s.explode!(number, index)
      assert_equal(@s.parse(result), number)
    end
  end

  def test_add
    num1 = @s.parse('[[[[4,3],4],4],[7,[[8,4],9]]]')
    num2 = @s.parse('[1,1]')
    rslt = @s.parse('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]')
    assert_equal(rslt, @s.add(num1, num2))
  end

  def test_add_list
    assert_equal(
      @s.parse(LIST1_RESULT),
      @s.add_list(LIST1_INPUT.map { |line| @s.parse(line) })
    )

    assert_equal(
      @s.parse(LIST2_RESULT),
      @s.add_list(LIST2_INPUT.map { |line| @s.parse(line) })
    )
  end

  def test_magnitude
    assert_equal(29, @s.magnitude(@s.parse('[9,1]')))
    assert_equal(21, @s.magnitude(@s.parse('[1,9]')))
    assert_equal(129, @s.magnitude(@s.parse('[[9,1],[1,9]]')))
  end
end
