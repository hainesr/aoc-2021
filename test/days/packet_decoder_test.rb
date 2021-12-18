# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/packet_decoder'

class AOC2021::PacketDecoderTest < MiniTest::Test
  PACKET1 = [
    'D2FE28',
    [
      1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0
    ].freeze
  ].freeze
  PACKET2 = [
    '38006F45291200',
    [
      0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
      0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0,
      0, 0, 0, 0, 0, 0, 0, 0
    ].freeze
  ].freeze
  PACKET3 = [
    'EE00D40C823060',
    [
      1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0,
      0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0,
      0, 1, 1, 0, 0, 0, 0, 0
    ].freeze
  ].freeze
  PACKET4 = '8A004A801A8002F478'
  PACKET5 = '620080001611562C8802118E34'
  PACKET6 = 'C200B40A82'
  PACKET7 = '04005AC33890'
  PACKET8 = '9C0141080250320F1802104A08'

  def setup
    @pd = AOC2021::PacketDecoder.new
  end

  def test_read_packet
    assert_equal(PACKET1[1], @pd.read_packet(PACKET1[0]))
    assert_equal(PACKET2[1], @pd.read_packet(PACKET2[0]))
    assert_equal(PACKET3[1], @pd.read_packet(PACKET3[0]))
  end

  def test_decode_packet
    # Literal packet.
    assert_equal([6, 2021], @pd.decode_packet(PACKET1[1].dup))

    # Test summing of versions. Don't have the ground truth for the values.
    assert_equal(16, @pd.decode_packet(@pd.read_packet(PACKET4)).first)
    assert_equal(12, @pd.decode_packet(@pd.read_packet(PACKET5)).first)

    # Test calculated values. Don't have the ground truth for the versions.
    assert_equal(3, @pd.decode_packet(@pd.read_packet(PACKET6)).last)
    assert_equal(54, @pd.decode_packet(@pd.read_packet(PACKET7)).last)
    assert_equal(1, @pd.decode_packet(@pd.read_packet(PACKET8)).last)
  end
end
