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
      ')' => [3, 1],
      ']' => [57, 2],
      '}' => [1197, 3],
      '>' => [25_137, 4]
    }.freeze

    OPENER = MATCH.keys.freeze

    def setup
      @input = read_input_file.split("\n")
    end

    def part1
      corruption_scores(@input).sum
    end

    def part2
      scores = autocomplete_scores(@input)
      scores[scores.length / 2]
    end

    def corruption_scores(input)
      input.map { |line| find_line_error(line) }.compact.map do |char|
        SCORES[char][0]
      end
    end

    def autocomplete_scores(input)
      completions = input.map do |line|
        find_line_error(line, return_missing: true)
      end.compact

      completions.map do |missing|
        missing.reduce(0) do |acc, char|
          (acc * 5) + SCORES[char][1]
        end
      end.sort
    end

    def find_line_error(line, return_missing: false)
      chars = line.chars
      match = [MATCH[chars.shift]]

      chars.each do |char|
        if OPENER.include?(char)
          match.push MATCH[char]
        else
          unless match.pop == char
            return return_missing ? nil : char
          end
        end
      end

      return_missing ? match.reverse : nil
    end
  end
end
