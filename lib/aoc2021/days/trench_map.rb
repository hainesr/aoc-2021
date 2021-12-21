# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class TrenchMap < Day
    KERNEL = [
      [-1, -1], [0, -1], [1, -1],
      [-1, 0], [0, 0], [1, 0],
      [-1, 1], [0, 1], [1, 1]
    ].freeze

    def setup
      @algorithm, @image = parse_input(read_input_file.split("\n\n"))
    end

    def part1
      enhance(enhance(@image, @algorithm), @algorithm).values.sum
    end

    def part2
      image = @image
      50.times do
        image = enhance(image, @algorithm)
      end
      image.values.sum
    end

    def enhance(image, algorithm, swap_void: true)
      new_void = swap_void ? 1 - image.default : 0
      ((min,),), ((max,),) = image.minmax_by { |k, _| k.first }
      range = ((min - 1)..(max + 1))

      range.each_with_object(Hash.new(new_void)) do |y, new_image|
        range.each do |x|
          index = KERNEL.each_with_object([]) do |(kx, ky), idx|
            idx << image[[x + kx, y + ky]]
          end.join.to_i(2)

          new_image[[x, y]] = algorithm[index]
        end
      end
    end

    # rubocop:disable Style/StringConcatenation
    def display(image)
      ((min,),), ((max,),) = image.minmax_by { |k, _| k.first }
      range = (min..max)

      range.reduce('') do |disp, y|
        disp + range.reduce('') do |str, x|
          str + (image[[x, y]].zero? ? ' ' : '#')
        end + "\n"
      end
    end
    # rubocop:enable Style/StringConcatenation

    def parse_input(input)
      [
        input[0].chars.map { |c| c == '#' ? 1 : 0 },
        input[1].split("\n")
                .each_with_object(Hash.new(0))
                .with_index do |(line, image), y|
                  line.chars.each_with_index do |c, x|
                    image[[x, y]] = (c == '#' ? 1 : 0)
                  end
                end
      ]
    end
  end
end
