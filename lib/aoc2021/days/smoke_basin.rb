# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SmokeBasin < Day
    def setup(input = read_input_file)
      @map = Map.new(input)
    end

    def part1
      @map.low_points.values.sum + @map.low_points.length
    end

    def part2
      @map.basin_sizes.max(3).reduce(&:*)
    end

    class Map
      attr_reader :low_points

      def initialize(input)
        @map = input.split("\n").map do |line|
          line.chars.map(&:to_i)
        end

        @max_y = @map.length - 1
        @max_x = @map[0].length - 1

        @low_points = find_low_points
      end

      def basin_sizes
        @low_points.keys.map do |point|
          explore_basin(point).length
        end
      end

      def explore_basin(start, basin = [])
        return basin if basin.include?(start)

        basin << start

        neighbours_for(start[1], start[0]).map do |nx, ny|
          next if @map[ny][nx] == 9

          explore_basin([ny, nx], basin)
        end.compact.flatten(1).uniq
      end

      private

      def find_low_points
        low_points = {}

        @map.each_with_index do |line, y|
          line.each_with_index do |point, x|
            low = neighbours_for(x, y).each do |nx, ny|
              break false if @map[ny][nx] <= point
            end

            low_points[[y, x]] = point if low
          end
        end

        low_points
      end

      def neighbours_for(x, y)
        [
          y.zero? ? nil : [x, y - 1],
          y == @max_y ? nil : [x, y + 1],
          x.zero? ? nil : [x - 1, y],
          x == @max_x ? nil : [x + 1, y]
        ].compact
      end
    end
  end
end
