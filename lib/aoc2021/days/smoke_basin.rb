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
          low = neighbours(x, y, max_x, max_y).each do |nx, ny|
            break false if input[ny][nx] <= point
          end

          low_points[[y, x]] = point if low
        end
      end

      low_points
    end

    def neighbours(x, y, max_x, max_y)
      [
        y.zero? ? nil : [x, y - 1],
        y == max_y ? nil : [x, y + 1],
        x.zero? ? nil : [x - 1, y],
        x == max_x ? nil : [x + 1, y]
      ].compact
    end
  end
end
