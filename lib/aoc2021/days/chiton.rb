# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class Chiton < Day
    def setup
      @grid = read_grid(read_input_file.split("\n"))
    end

    def part1
      grid = @grid.dup
      calculate_risk(grid)
      grid[[99, 99]]
    end

    def calculate_risk(grid)
      grid[[0, 0]] = 0
      grid.each do |(x, y), r|
        from = [[x, y - 1], [x - 1, y]].reject do |(a, b)|
          a.negative? || b.negative?
        end
        next if from.empty?

        risks = from.map { |f| grid[f] }
        grid[[x, y]] = r + risks.min
      end
    end

    def read_grid(input)
      input.each_with_object({}).with_index do |(line, grid), y|
        line.chars.each_with_index { |c, x| grid[[x, y]] = c.to_i }
      end
    end
  end
end
