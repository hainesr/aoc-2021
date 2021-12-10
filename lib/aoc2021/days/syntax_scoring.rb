# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class SyntaxScoring < Day
    MATCH = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }.freeze

    SCORES = {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25_137
    }.freeze

    OPENER = MATCH.keys.freeze

    def setup
      @input = read_input_file.split("\n")
    end

    def part1
      scores(@input).sum
    end

    def scores(input)
      input.map { |line| find_line_error(line) }.compact.map do |char|
        SCORES[char]
      end
    end

    def find_line_error(line)
      chars = line.chars
      match = [MATCH[chars.shift]]

      chars.each do |char|
        if OPENER.include?(char)
          match.push MATCH[char]
        else
          return char unless match.pop == char
        end
      end

      nil
    end
  end
end
