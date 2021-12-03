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

    def part2
      life_support_rating(@input).reduce(&:*)
    end

    def power_consumption(input)
      half = input.length / 2

      sums = input.map(&:chars).map { |l| l.map(&:to_i) }.transpose.map(&:sum)
      gamma = sums.map { |s| s > half ? '1' : '0' }.join.to_i(2)
      epsilon = sums.map { |s| s > half ? '0' : '1' }.join.to_i(2)

      [gamma, epsilon]
    end

    def life_support_rating(input)
      [generator_rating(input.dup), scrubber_rating(input.dup)]
    end

    def generator_rating(input, column = 0)
      return input[0].to_i(2) if input.length == 1

      groups = input.group_by { |line| line[column] }
      if groups['0'].length > groups['1'].length
        generator_rating(groups['0'], column += 1)
      else
        generator_rating(groups['1'], column += 1)
      end
    end

    def scrubber_rating(input, column = 0)
      return input[0].to_i(2) if input.length == 1

      groups = input.group_by { |line| line[column] }
      if groups['1'].length < groups['0'].length
        scrubber_rating(groups['1'], column += 1)
      else
        scrubber_rating(groups['0'], column += 1)
      end
    end
  end
end
