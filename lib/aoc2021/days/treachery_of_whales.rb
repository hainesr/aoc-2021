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

    def fuel_calculator(crabs)
      median = median(crabs)

      crabs.map { |loc| (median - loc).abs }.sum.to_i
    end

    def median(list)
      sorted = list.sort
      mid_point = (sorted.length - 1) / 2.0
      (sorted[mid_point.floor] + sorted[mid_point.ceil]) / 2.0
    end
  end
end
