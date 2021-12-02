# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class Dive < Day
    def setup
      @input = read_directions(read_input_file)
    end

    def part1
      find_destination_coords(@input).reduce(&:*)
    end

    def part2
      find_destination_coords_aim(@input).reduce(&:*)
    end

    def find_destination_coords(input)
      h = 0
      d = 0

      input.each do |dir, mag|
        case dir
        when :forward
          h += mag
        when :up
          d -= mag
        when :down
          d += mag
        end
      end

      [h, d]
    end

    def find_destination_coords_aim(input)
      h = 0
      d = 0
      a = 0

      input.each do |dir, mag|
        case dir
        when :forward
          h += mag
          d += a * mag
        when :up
          a -= mag
        when :down
          a += mag
        end
      end

      [h, d]
    end

    def read_directions(input)
      input.split("\n").map(&:split).map do |dir, mag|
        [dir.to_sym, mag.to_i]
      end
    end
  end
end
