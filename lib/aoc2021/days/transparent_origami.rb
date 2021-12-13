# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class TransparentOrigami < Day
    def setup
      @dots, @folds = parse_input(read_input_file.split("\n\n"))
    end

    def part1
      fold(@folds[0], @dots).length
    end

    def fold(fold, dots)
      axis, num = fold

      dots.map do |dot|
        dot[axis] -= (dot[axis] - num) * 2 if dot[axis] > num

        dot
      end.uniq
    end

    def parse_input(input)
      dots = input[0].split("\n").map do |line|
        line.split(',').map(&:to_i)
      end

      folds = input[1].split("\n").map do |line|
        line.split[2].split('=').map do |c|
          case c
          when 'x'
            0
          when 'y'
            1
          else
            c.to_i
          end
        end
      end

      [dots, folds]
    end
  end
end
