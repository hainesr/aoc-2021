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
      @target = {
        x: (277..318),
        y: (-92..-53)
      }
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
      (1..(target[:y].min + 1).abs).sum
    end

    def part2
      sim(@target).length
    end

    # Simulate the x and y axes separately noting the 'step' on which they
    # hit the target. Then produce a union set of the two lists. Only
    # complication is that the x velocity can hit zero, so note that and
    # allow the y step to go higher in that instance.
    def sim(target)
      x_list = sim_x(target[:x])
      y_list = sim_y(target[:y])

      x_list.each_with_object([]) do |(xv, xs, xz), union|
        y_list.each do |(yv, ys)|
          union << [xv, yv] if xs == ys || (xz && (ys > xs))
        end
      end.uniq
    end

    private

    def sim_x(target)
      range = ((Math.sqrt(target.min * 2).round)..target.max)
      range.each_with_object([]) do |vel, list|
        x = 0
        st_vel = vel
        step = 1

        while x <= target.max
          x += vel
          vel -= 1 if vel.positive?

          list << [st_vel, step, vel.zero?] if target.cover?(x)
          break if vel.zero?

          step += 1
        end
      end
    end

    def sim_y(target)
      range = (target.min..((target.min + 1).abs))
      range.each_with_object([]) do |vel, list|
        y = 0
        st_vel = vel
        step = 1

        while y >= target.min
          y += vel
          vel -= 1

          list << [st_vel, step] if target.cover?(y)

          step += 1
        end
      end
    end
  end
end
