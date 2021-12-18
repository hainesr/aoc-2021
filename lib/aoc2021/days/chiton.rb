# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'
require 'aoc2021/common/a_star'

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

    def part2
      grid = multiply_grid(@grid)
      calculate_risk_astar(grid)
    end

    def calculate_risk_astar(grid)
      max = grid.keys.max_by { |(a, _)| a }.first

      neighbours = lambda { |pos|
        x, y = pos
        [[x, y - 1], [x - 1, y], [x, y + 1], [x + 1, y]].reject do |(a, b)|
          a.negative? || b.negative? || a > max || b > max
        end
      }

      cost = lambda { |pos|
        grid[pos]
      }

      heuristic = lambda { |pos|
        x, y = pos
        ((max - x) + (max - y))
      }

      Common::AStar.solve([0, 0], [max, max], neighbours, cost, heuristic)
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

    def multiply_grid(grid, max = 100)
      grid.each_with_object({}) do |((x, y), r), new_grid|
        (0..4).each do |mx|
          (0..4).each do |my|
            nx = x + (max * mx)
            ny = y + (max * my)
            nr = r + mx + my
            nr -= 9 if nr > 9
            new_grid[[nx, ny]] = nr
          end
        end
      end
    end

    def read_grid(input)
      input.each_with_object({}).with_index do |(line, grid), y|
        line.chars.each_with_index { |c, x| grid[[x, y]] = c.to_i }
      end
    end
  end
end
