# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class GiantSquid < Day
    def setup
      @numbers, @boards = read_boards(read_input_file)
    end

    def part1
      winner, remaining = play(@boards, @numbers)
      remaining.sum * winner
    end

    def move(boards, number)
      boards.map do |board|
        board.map do |line|
          line.map { |n| n == number ? nil : n }
        end
      end
    end

    def won?(board)
      board.each { |line| return true if line.all?(nil) }
      board.transpose.each { |line| return true if line.all?(nil) }

      false
    end

    def play(boards, numbers)
      numbers.each do |number|
        boards = move(boards, number)

        boards.each do |board|
          return [number, board.flatten.compact] if won?(board)
        end
      end
    end

    def read_boards(input)
      nums, *rest = input.split("\n\n")

      # Read the numbers.
      numbers = nums.split(',').map(&:to_i)

      # Read the boards.
      boards = rest.map { |b| b.split("\n").map { |l| l.split.map(&:to_i) } }

      [numbers, boards]
    end
  end
end
