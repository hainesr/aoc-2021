# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

module AOC2021
  module Common
    class PriorityQueue
      attr_reader :length

      def initialize
        @queue = []
        @priority = 0
        @length = 0
      end

      def []=(data, priority)
        if priority < @priority
          raise 'Priority should increase: ' \
                "given #{priority}; current #{@priority}"
        end

        (@queue[priority] ||= []) << data
        @length += 1
      end

      def pop
        return nil if @length.zero?

        @priority += 1 until (q = @queue[@priority]) && !q.empty?
        @length -= 1
        q.pop
      end
    end
  end
end
