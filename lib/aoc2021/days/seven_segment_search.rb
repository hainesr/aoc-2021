# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SevenSegmentSearch < Day
    def setup
      @input = read_input_file.split("\n").map do |line|
        line.split(' | ').map(&:split)
      end
    end

    def part1
      count_unique_outputs(@input)
    end

    def count_unique_outputs(input)
      input.map do |_, out|
        out.count { [2, 3, 4, 7].include?(_1.length) }
      end.sum
    end
  end
end
