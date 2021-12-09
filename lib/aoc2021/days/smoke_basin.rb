# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SmokeBasin < Day
    def setup
      @input = read_input_file.split("\n").map do |line|
        line.chars.map(&:to_i)
      end
    end

    def part1
      risk_level(@input)
    end

    def risk_level(input)
      points = find_low_points(input)
      points.values.sum + points.length
    end

    def find_low_points(input)
      max_y = input.length - 1
      max_x = input[0].length - 1
      low_points = {}

      input.each_with_index do |line, y|
        line.each_with_index do |point, x|
          up = y.zero? ? nil : [x, y - 1]
          down = y == max_y ? nil : [x, y + 1]
          left = x.zero? ? nil : [x - 1, y]
          right = x == max_x ? nil : [x + 1, y]

          low = [up, down, left, right].compact.each do |tx, ty|
            break false if input[ty][tx] <= point
          end

          low_points[[y, x]] = point if low
        end
      end

      low_points
    end
  end
end
