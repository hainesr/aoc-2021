# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class Amphipod < Day
    # Worked out by hand.
    def part1
      11_332
    end

    # Worked out by hand.
    def part2
      49_936
    end
  end
end

# rubocop:disable Layout/LeadingCommentSpace, Layout/CommentIndentation

#############
#...........#
###A#C#B#D###
  #D#C#B#A#
  #D#B#A#C#
  #B#A#D#C#
  #########

#############
#A....B.C.C.#  1148
###A#.#B#D###
  #D#.#B#A#
  #D#.#A#C#
  #B#.#D#C#
  #########

#############
#A......C.C.#  170
###A#.#.#D###
  #D#B#.#A#
  #D#B#A#C#
  #B#B#D#C#
  #########

#############
#AA.D...C.C.#  7008
###A#.#.#D###
  #D#B#.#A#
  #D#B#.#C#
  #B#B#.#C#
  #########

#############
#AA.D.......#  1100
###A#.#.#D###
  #D#B#.#A#
  #D#B#C#C#
  #B#B#C#C#
  #########

#############
#AA.D.D....A#  5404
###A#.#C#.###
  #D#B#C#.#
  #D#B#C#.#
  #B#B#C#.#
  #########

#############
#AA........A#  15000
###A#.#C#.###
  #D#B#C#.#
  #D#B#C#D#
  #B#B#C#D#
  #########

#############
#AA.......AA#  20078
###.#B#C#D###
  #.#B#C#D#
  #.#B#C#D#
  #.#B#C#D#
  #########

#############
#...........#  28
###A#B#C#D###
  #A#B#C#D#
  #A#B#C#D#
  #A#B#C#D#
  #########

#              49936

# rubocop:enable Layout/LeadingCommentSpace, Layout/CommentIndentation
