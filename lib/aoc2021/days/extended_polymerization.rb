# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class ExtendedPolymerization < Day
    def setup
      @template, @pairs, @insertions =
        read_input(read_input_file.split("\n\n"))
    end

    def part1
      quantity(@template, @pairs.dup, @insertions, 10)
    end

    def part2
      quantity(@template, @pairs.dup, @insertions, 40)
    end

    def quantity(template, pairs, insertions, repeat)
      repeat.times do
        pairs = insert(pairs, insertions)
      end

      counts = count_letters(template, pairs).values
      counts.max - counts.min
    end

    def insert(pairs, insertions)
      new_pairs = Hash.new(0)

      pairs.each do |pair, num|
        insertion = insertions[pair]

        new_pairs[[pair[0], insertion]] += num
        new_pairs[[insertion, pair[1]]] += num
      end

      new_pairs
    end

    def count_letters(template, pairs)
      counts = Hash.new(0)
      counts[template[-1]] = 1

      pairs.each do |(letter, _), n|
        counts[letter] += n
      end

      counts
    end

    def read_input(input)
      pairs = input[0].chars.each_cons(2).tally
      pairs.default = 0

      ins = input[1].split("\n").map do |line|
        line.split(' -> ').map do |str|
          str.length == 2 ? str.chars : str
        end
      end.to_h

      [input[0], pairs, ins]
    end
  end
end
