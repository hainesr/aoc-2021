# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'aoc2021'

module AOC2021
  class PacketDecoder < Day
    def setup
      @packet = read_packet(read_input_file)
    end

    def part1
      decode_packet(@packet)
    end

    def decode_packet(data)
      shift_decode = ->(n) { data.shift(n).join.to_i(2) }

      version = shift_decode[3]
      type = shift_decode[3]

      if type == 4
        # Just gobble up the "value" data for now. Don't need it.
        loop do
          block_id = data.shift
          _block = data.shift(4)
          break if block_id.zero?
        end

        return version
      end

      inner_packets =
        if shift_decode[1].zero?
          inner_length = shift_decode[15]
          inner_data = data.shift(inner_length)
          inner_pkts = []
          inner_pkts << decode_packet(inner_data) until inner_data.empty?
          inner_pkts
        else
          inner_num = shift_decode[11]
          inner_num.times.map { decode_packet(data) }
        end

      version + inner_packets.sum
    end

    def read_packet(input)
      data = input.to_i(16).digits(2).reverse
      ((input.length * 4) - data.length).times { data.unshift(0) }

      data
    end
  end
end
