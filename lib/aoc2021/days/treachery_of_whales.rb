# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class TreacheryOfWhales < Day
    def setup
      @crabs = read_input_file.split(',').map(&:to_i)
    end

    def part1
      fuel_calculator(@crabs)
    end

    def part2
      fuel_calculator_max(@crabs)
    end

    def fuel_calculator(crabs)
      median = median(crabs)

      crabs.map { |loc| (median - loc).abs }.sum.to_i
    end

    def fuel_calculator_max(crabs)
      mean = (crabs.sum / crabs.length).floor

      # Try integers either side of the mean and take the smallest result.
      [mean, mean + 1].map do |test|
        crabs.map do |loc|
          n = (test - loc).abs
          (n * (n + 1)) / 2
        end.sum
      end.min
    end

    def median(list)
      sorted = list.sort
      mid_point = (sorted.length - 1) / 2.0
      (sorted[mid_point.floor] + sorted[mid_point.ceil]) / 2.0
    end
  end
end
