# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SeaCucumber < Day
    def setup
      @width, @height, @east, @south = read_map(read_input_file.split("\n"))
    end

    def part1(width = @width, height = @height, east = @east, south = @south)
      1.step do |count|
        move, east, south = step(width, height, east, south)
        break count unless move
      end
    end

    def step(width, height, east, south)
      move = false

      new_east = east.map do |loc|
        x = loc % width
        y = loc / width
        next_loc = (y * width) + ((x + 1) % width)
        if east.include?(next_loc) || south.include?(next_loc)
          loc
        else
          move = true
          next_loc
        end
      end

      new_south = south.map do |loc|
        x = loc % width
        y = loc / width
        next_loc = (((y + 1) % height) * width) + x
        if south.include?(next_loc) || new_east.include?(next_loc)
          loc
        else
          move = true
          next_loc
        end
      end

      [move, new_east, new_south]
    end

    def read_map(input)
      east = []
      south = []
      width = input.first.length
      height = input.length

      input.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          case c
          when '>'
            east << ((y * width) + x)
          when 'v'
            south << ((y * width) + x)
          end
        end
      end

      [width, height, east, south]
    end
  end
end
