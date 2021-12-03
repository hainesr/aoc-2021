# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class BinaryDiagnostic < Day
    def setup
      @input = read_input_file.split
    end

    def part1
      power_consumption(@input).reduce(&:*)
    end

    def power_consumption(input)
      half = input.length / 2

      sums = input.map(&:chars).map { |l| l.map(&:to_i) }.transpose.map(&:sum)
      gamma = sums.map { |s| s > half ? '1' : '0' }.join.to_i(2)
      epsilon = sums.map { |s| s > half ? '0' : '1' }.join.to_i(2)

      [gamma, epsilon]
    end
  end
end
