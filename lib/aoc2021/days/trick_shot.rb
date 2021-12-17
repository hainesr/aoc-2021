# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class TrickShot < Day
    def setup
      @target = [(277..318), (-92..-53)]
    end

    # For part 1 we can ignore x, as it just needs to be whatever gets
    # to zero over the target. For y to get as high as possible it needs
    # to hit the target as near to the bottom as possible (so it's going
    # as fast as possible, which means it went as high as possible).
    # Given that we start at y = 0 and will come back through 0 that
    # means to be as fast as possible the step which hits must give
    # y = target_min_y, which means the y velocity must be -target_min_y
    # for that step, which means velocity must be (-target_min_y + 1)
    # for the previous step---which hits y = 0. So initial y velocity
    # must be (-target_min_y + 1).abs. Because y velocity decreases by 1
    # every step the highest height is the sum of all the numbers 1 to
    # (-target_min_y + 1).abs.
    def part1(target = @target)
      (1..(target[1].min + 1).abs).sum
    end
  end
end
