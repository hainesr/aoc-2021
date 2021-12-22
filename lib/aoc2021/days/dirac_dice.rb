# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class DiracDice < Day
    ROLL_DISTRIBUTIONS = [
      # Total, frequency
      [3, 1],
      [4, 3],
      [5, 6],
      [6, 7],
      [7, 6],
      [8, 3],
      [9, 1]
    ].freeze

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

    def part2
      quantum_dice(@p1_start, 0, 0, @p2_start, 0, 0, 1).max
    end

    # rubocop:disable Metrics/ParameterLists
    # Every time we enter this method, we will have swapped the players.
    def quantum_dice(pos1, score1, wins1, pos2, score2, wins2, multiplier)
      # The second player(s) will have just had their turn(s).
      return [wins1, wins2 + multiplier] if score2 >= 21

      total_wins1 = 0
      total_wins2 = 0

      ROLL_DISTRIBUTIONS.each do |(total, freq)|
        new_pos = ((pos1 + total - 1) % 10) + 1
        new_wins2, new_wins1 = quantum_dice(
          pos2, score2, wins2,
          new_pos, score1 + new_pos, wins1,
          multiplier * freq
        )

        total_wins1 += new_wins1
        total_wins2 += new_wins2
      end

      [total_wins1, total_wins2]
    end
    # rubocop:enable Metrics/ParameterLists
  end
end
