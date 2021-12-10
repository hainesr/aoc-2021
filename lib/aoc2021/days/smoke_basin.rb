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
      @map = read_input_file.split("\n").map do |line|
        line.chars.map(&:to_i)
      end

      @low_points = find_low_points(@map)
    end

    def part1
      risk_level
    end

    def part2
      basin_sizes.max(3).reduce(&:*)
    end

    def risk_level(low_points = @low_points)
      low_points.values.sum + low_points.length
    end

    def basin_sizes(map = @map, low_points = @low_points)
      low_points.keys.map do |point|
        explore_basin(map, point).length
      end
    end

    def explore_basin(map, start, basin = [])
      return basin if basin.include?(start)

      basin << start

      max_y = map.length - 1
      max_x = map[0].length - 1
      neighbours(start[1], start[0], max_x, max_y).map do |nx, ny|
        next if map[ny][nx] == 9

        explore_basin(map, [ny, nx], basin)
      end.compact.flatten(1).uniq
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
