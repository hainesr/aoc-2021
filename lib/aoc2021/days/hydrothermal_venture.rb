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

    def map_overlaps(list)
      grid = {}

      list.each do |(x1, y1), (x2, y2)|
        if x1 == x2
          y1, y2 = [y1, y2].sort
          (y1..y2).each do |y|
            grid[[x1, y]] ||= 0
            grid[[x1, y]] += 1
          end
        elsif y1 == y2
          x1, x2 = [x1, x2].sort
          (x1..x2).each do |x|
            grid[[x, y1]] ||= 0
            grid[[x, y1]] += 1
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
