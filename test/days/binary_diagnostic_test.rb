# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/binary_diagnostic'

class AOC2021::BinaryDiagnosticTest < MiniTest::Test
  INPUT = <<~EOI.split
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
  EOI

  def setup
    @bd = ::AOC2021::BinaryDiagnostic.new
  end

  def test_power_consumption
    assert_equal([22, 9], @bd.power_consumption(INPUT))
  end

  def test_life_support_rating
    assert_equal([23, 10], @bd.life_support_rating(INPUT))
  end
end
