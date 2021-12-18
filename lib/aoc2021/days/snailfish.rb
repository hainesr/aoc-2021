# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class Snailfish < Day
    def setup
      @input = read_input_file.split("\n").map { |line| parse(line) }
    end

    def part1
      magnitude(add_list(@input))
    end

    def magnitude(number)
      loop do
        max_depth = number.map(&:last).max
        break if max_depth.zero?

        index = number.index { |n| n.last == max_depth }
        number[index] = [
          (3 * number[index].first) + (2 * number[index + 1].first),
          (number[index].last - 1)
        ]

        number.delete_at(index + 1)
      end

      number.first.first
    end

    def add_list(list)
      list.reduce { |n1, n2| add(n1, n2) }
    end

    def add(num1, num2)
      reduce((num1 + num2).map { |n, d| [n, d + 1] })
    end

    def reduce(number)
      loop do
        if (index = explode_index(number))
          explode!(number, index)
          next
        end

        if (index = split_index(number))
          split!(number, index)
          next
        end

        # Will only get here if there were no explode!s or split!s.
        break
      end

      number
    end

    def explode_index(number)
      number.index { |(_, d)| d > 4 }
    end

    def split_index(number)
      number.index { |(n, _)| n > 9 }
    end

    def explode!(number, index)
      (n1, d1), (n2,) = number.slice(index, 2)
      number[index - 1][0] += n1 unless index.zero?
      number[index + 2][0] += n2 unless number[index + 2].nil?
      number.delete_at(index)
      number[index] = [0, (d1 - 1)]
    end

    def split!(number, index)
      n, d = number[index]
      num, one = n.divmod(2)
      number.insert(index + 1, [num + one, d + 1])
      number[index] = [num, d + 1]
    end

    def parse(str)
      depth = 0
      str.chars.each_with_object([]) do |char, list|
        case char
        when /\d/
          list << [char.to_i, depth]
        when '['
          depth += 1
        when ']'
          depth -= 1
        end
      end
    end
  end
end
