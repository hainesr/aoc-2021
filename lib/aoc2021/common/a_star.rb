# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require_relative 'priority_queue'

module AOC2021
  module Common
    module AStar
      module_function

      def solve(start_pos, end_pos, neighbours, cost, heuristic)
        g = Hash.new(Float::INFINITY)
        open_list = PriorityQueue.new
        closed_list = {}
        prev_list = {}

        open_list[start_pos] = heuristic[start_pos]
        g[start_pos] = 0

        while (current_pos = open_list.pop)
          next if closed_list[current_pos]

          closed_list[current_pos] = true
          return g[current_pos] if current_pos == end_pos

          neighbours[current_pos].each do |neighbour|
            next if closed_list[neighbour]

            g_score = g[current_pos] + cost[neighbour]
            next if g_score >= g[neighbour]

            prev_list[neighbour] = current_pos
            g[neighbour] = g_score
            open_list[neighbour] = g_score + heuristic[neighbour] # f = g + h
          end
        end

        nil
      end

      def path(previous, start)
        path = [start]
        current = start

        while (current = previous[current])
          path.unshift(current)
        end

        path
      end
    end
  end
end
