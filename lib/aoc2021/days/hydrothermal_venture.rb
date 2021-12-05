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
      grid = Hash.new(0)

      list.each do |aligned, coords|
        next if aligned_only && !aligned

        coords.each do |x, y|
          grid[[x, y]] += 1
        end
      end

      grid
    end

    def read_coords(input)
      pairs = input.map do |line|
        line.split(' -> ').map do |coords|
          coords.split(',').map(&:to_i)
        end
      end

      pairs.map do |(x1, y1), (x2, y2)|
        x_range = x1 > x2 ? x1.downto(x2).to_a : x1.upto(x2).to_a
        y_range = y1 > y2 ? y1.downto(y2).to_a : y1.upto(y2).to_a

        if x1 == x2
          [true, ([x1] * y_range.length).zip(y_range)]
        elsif y1 == y2
          [true, x_range.zip([y1] * x_range.length)]
        else
          [false, x_range.zip(y_range)]
        end
      end
    end
  end
end
