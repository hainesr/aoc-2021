# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class DiracDice < Day
    def setup
      @p1_start = 4
      @p2_start = 3
    end

    def part1(p1_start = @p1_start, p2_start = @p2_start)
      # Store position - 1 so we can use mod.
      position = [p1_start.pred, p2_start.pred]
      score = [0, 0]

      0.step do |turn|
        player = turn % 2

        # The three dice rolls can be determined by the turn, thus:
        # (((3 * turn) + 1 - 1) % 100 + 1) +
        # (((3 * turn) + 2 - 1) % 100 + 1) +
        # (((3 * turn) + 3 - 1) % 100 + 1)
        # =
        # (((9 * turn) + 3) % 100 + 3)
        position[player] = (position[player] +
                           ((((9 * turn) + 3) % 100) + 3)) % 10

        score[player] += position[player] + 1 # Remember position is one lower.

        # When one player hits 1000, return the other player's score and the
        # number of times the die has been rolled.
        return score[1 - player] * (turn + 1) * 3 if score[player] >= 1000
      end
    end
  end
end
