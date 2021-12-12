# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class PassagePathing < Day
    def setup
      @graph = read_graph(read_input_file.split("\n"))
    end

    def part1(graph = @graph)
      paths = []
      follow_paths(graph, :start, :end, [], paths)
      paths.length
    end

    def follow_paths(graph, start, finish, path, paths)
      path += [start]

      if start == finish
        paths.push(path)
        return paths
      end

      graph[start].each do |cave|
        not_seen = !lower?(cave) || !path.include?(cave)
        follow_paths(graph, cave, finish, path, paths) if not_seen
      end
    end

    def read_graph(input)
      graph = Hash.new { |k, v| k[v] = [] }

      input.each do |line|
        from, to = line.split('-').map(&:to_sym)
        graph[from] << to unless to == :start || from == :end
        graph[to] << from unless from == :start || to == :end
      end

      graph
    end

    def lower?(c)
      c == c.downcase
    end
  end
end
