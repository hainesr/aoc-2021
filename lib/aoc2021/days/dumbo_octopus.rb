# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class DumboOctopus < Day
    NEIGHBOURS = ([-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]).freeze

    def setup
      @grid = build_grid(read_input_file)
    end

    def part1(grid = @grid.dup, steps = 100)
      steps.times.reduce(0) do |flashes, _|
        flashes + step(grid).length
      end
    end

    def step(grid)
      flashed = []
      grid.each { |octopus, _| grid[octopus] += 1 }
      grid.select { |_, energy| energy > 9 }.each do |octopus, _|
        flash(grid, octopus, flashed)
      end

      flashed
    end

    def flash(grid, octopus, flashed)
      return if flashed.include?(octopus)

      grid[octopus] = 0
      flashed << octopus

      neighbours_for(octopus).each do |neighbour|
        next if flashed.include? neighbour

        grid[neighbour] += 1
        flash(grid, neighbour, flashed) if grid[neighbour] > 9
      end
    end

    def build_grid(input)
      grid = {}

      input.split("\n").each_with_index do |line, y|
        line.chars.each_with_index do |octopus, x|
          grid[[x, y]] = octopus.to_i
        end
      end

      grid
    end

    def neighbours_for((ox, oy))
      NEIGHBOURS.map { |x, y| [ox + x, oy + y] }.reject do |x, y|
        x.negative? || x > 9 || y.negative? || y > 9
      end
    end
  end
end
