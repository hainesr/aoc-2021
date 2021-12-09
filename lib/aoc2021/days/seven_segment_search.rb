# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SevenSegmentSearch < Day
    def setup
      @input = read_input_file.split("\n").map do |line|
        line.split(' | ').map do |seq|
          seq.split.map { |num| num.chars.sort }
        end
      end
    end

    def part1
      count_unique_outputs(@input)
    end

    def part2
      decode(@input)
    end

    def decode(input)
      input.map do |line|
        decode_line(line).join.to_i
      end.sum
    end

    def decode_line(line)
      lookup = identify_numbers_for_line(line[0])

      line[1].map do |digit|
        lookup[digit]
      end
    end

    # rubocop:disable Metrics/AbcSize
    def identify_numbers_for_line(line)
      lookup = {}
      signals = line.sort_by(&:length)

      # 1, 4, 7, 8.
      lookup[signals.first] = 1
      lookup[signals[1]] = 7
      lookup[signals[2]] = 4
      lookup[signals.last] = 8

      # 0, 6, 9.
      six = []
      signals[6, 3].each do |sig|
        if (sig - (signals[1] + signals[2])).length == 1
          lookup[sig] = 9
        elsif (signals[0] - sig).length == 1
          lookup[sig] = 6
          six = sig
        else
          lookup[sig] = 0
        end
      end

      # 2, 3, 5.
      signals[3, 3].each do |sig|
        lookup[sig] = if (sig - signals[0]).length == 3
                        3
                      elsif (sig - six).empty?
                        5
                      else
                        2
                      end
      end

      lookup
    end
    # rubocop:enable Metrics/AbcSize

    def count_unique_outputs(input)
      input.map do |_, out|
        out.count { [2, 3, 4, 7].include?(_1.length) }
      end.sum
    end
  end
end
