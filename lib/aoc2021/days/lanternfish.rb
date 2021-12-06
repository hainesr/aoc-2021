# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class Lanternfish < Day
    def setup
      @input = tally_fish(read_input_file)
    end

    def part1
      days(@input.dup, days: 80).sum
    end

    def part2
      days(@input.dup, days: 256).sum
    end

    def days(fish, days: 1)
      days.times do
        zero = fish.shift
        fish[6] += zero
        fish[8] = zero
      end

      fish
    end

    def tally_fish(input)
      fish = [0] * 9
      input.split(',').map(&:to_i).sort.tally.each do |k, v|
        fish[k] = v
      end

      fish
    end
  end
end
