# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class ReactorReboot < Day
    def setup
      @instructions = read_instructions(read_input_file)
      @cubes = reboot
    end

    def part1
      # Constrict output to the -50..50 cube in the centre.
      small_range = -50..50
      small_cube = Cube.new(small_range, small_range, small_range)

      @cubes.sum { |c, v| c.intersection(small_cube).size * v }
    end

    def part2
      @cubes.sum { |c, v| c.size * v }
    end

    # Model a cube using a range for each axis.
    Cube = Struct.new(:x, :y, :z) do
      def intersects?(other)
        range_intersects?(x, other.x) &&
          range_intersects?(y, other.y) &&
          range_intersects?(z, other.z)
      end

      def intersection(other)
        Cube.new(
          range_intersection(x, other.x),
          range_intersection(y, other.y),
          range_intersection(z, other.z)
        )
      end

      def superset?(other)
        range_superset?(x, other.x) &&
          range_superset?(y, other.y) &&
          range_superset?(z, other.z)
      end

      def size
        x.size * y.size * z.size
      end

      private

      def range_intersects?(a, b)
        a.begin <= b.end && b.begin <= a.end
      end

      def range_intersection(a, b)
        [a.begin, b.begin].max..[b.end, a.end].min
      end

      def range_superset?(a, b)
        a.begin <= b.begin && b.end <= a.end
      end
    end

    def reboot(instructions = @instructions)
      # Keep track of the cube states. Hash of {cube: state} (zero default).
      instructions.each_with_object(Hash.new(0)) do |(toggle, cube), cubes|
        updates = Hash.new(0)
        delete_list = []

        cubes.each do |c, state|
          next unless c.intersects?(cube)

          if cube.superset?(c)
            delete_list << c
          else
            updates[c.intersection(cube)] -= state # Winding rule.
          end
        end

        delete_list.each { |d| cubes.delete(d) }

        # Use a sort of winding rule (see above for state inversion).
        # Go through the update list:
        #   if on just add 1.
        #   if off do nothing (updates defaults to 0).
        #   if on/off intersection the +1 was cancelled with a -1 (above).
        #   if off/off intersection the -1 was canceled with a +1 (above).
        updates[cube] += 1 if toggle

        # Merge (add) the values of duplicate cubes and remove zeros.
        cubes.merge!(updates) { |_, v1, v2| v1 + v2 }
        cubes.reject! { |_, v| v.zero? }
      end
    end

    # rubocop:disable Security/Eval
    def read_instructions(input)
      input.split("\n").map do |line|
        toggle, coords = line.split
        toggle = toggle == 'on'
        xr, yr, zr = coords.split(',').map { |c| c.split('=').last }
        cube = Cube.new(eval(xr), eval(yr), eval(zr))

        [toggle, cube]
      end
    end
    # rubocop:enable Security/Eval
  end
end
