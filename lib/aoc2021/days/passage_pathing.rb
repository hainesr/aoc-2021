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

    def part2(graph = @graph)
      paths = []
      follow_paths(graph, :start, :end, [], paths, part2: true)
      paths.length
    end

    def follow_paths(graph, start, finish, path, paths, part2: false)
      path += [start]

      if start == finish
        paths.push(path)
        return paths
      end

      graph[start].each do |cave|
        valid = !lower?(cave) ||
                (part2 ? valid?(path, cave) : !path.include?(cave))
        follow_paths(graph, cave, finish, path, paths, part2: part2) if valid
      end
    end

    def valid?(path, cave)
      return true unless path.include?(cave)
      return false if path.count(cave) > 1

      (path + [cave]).select(&method(:lower?)).tally.values.count(2) < 2
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
