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

    def part2
      @folds.each do |fold|
        @dots = fold(fold, @dots)
      end

      "\n#{display(@dots)}"
    end

    def fold(fold, dots)
      axis, num = fold

      dots.map do |dot|
        dot[axis] -= (dot[axis] - num) * 2 if dot[axis] > num

        dot
      end.uniq
    end

    # rubocop:disable Style/StringConcatenation
    def display(dots)
      max_x = dots.max_by { |dot| dot[0] }[0]
      max_y = dots.max_by { |dot| dot[1] }[1]

      (0..max_y).reduce('') do |disp, y|
        disp + (0..max_x).reduce('') do |str, x|
          str + (dots.include?([x, y]) ? '#' : ' ')
        end + "\n"
      end
    end
    # rubocop:enable Style/StringConcatenation

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
