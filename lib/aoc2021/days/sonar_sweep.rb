# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SonarSweep < Day
    def setup
      @input = read_input_file.split.map(&:to_i)
    end

    def part1
      count_increments(@input)
    end

    def count_increments(input)
      previous = input.first

      input.reduce(0) do |sum, i|
        sum += 1 if i > previous
        previous = i
        sum
      end
    end
  end
end
