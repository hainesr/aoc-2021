# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class HydrothermalVenture < Day
    def setup
      @coords = read_coords(read_input_file.split("\n"))
    end

    def part1
      map_overlaps(@coords).count { |_, v| v > 1 }
    end

    def part2
      map_overlaps(@coords, aligned_only: false).count { |_, v| v > 1 }
    end

    def map_overlaps(list, aligned_only: true)
      grid = {}

      list.each do |(x1, y1), (x2, y2)|
        x_range = x1 > x2 ? x1.downto(x2).to_a : x1.upto(x2).to_a
        y_range = y1 > y2 ? y1.downto(y2).to_a : y1.upto(y2).to_a

        if x1 == x2
          y_range.each do |y|
            grid[[x1, y]] ||= 0
            grid[[x1, y]] += 1
          end
        elsif y1 == y2
          x_range.each do |x|
            grid[[x, y1]] ||= 0
            grid[[x, y1]] += 1
          end
        else
          unless aligned_only
            x_range.zip(y_range).each do |x, y|
              grid[[x, y]] ||= 0
              grid[[x, y]] += 1
            end
          end
        end
      end

      grid
    end

    def read_coords(input)
      input.map do |line|
        line.split(' -> ').map do |coords|
          coords.split(',').map(&:to_i)
        end
      end
    end
  end
end
