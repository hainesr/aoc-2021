# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2021/days/passage_pathing'

class AOC2021::PassagePathingTest < MiniTest::Test
  INPUT = <<~EOI.split("\n")
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
  EOI

  def setup
    @pp = AOC2021::PassagePathing.new
  end

  def test_lower?
    assert(@pp.lower?(:a))
    assert(@pp.lower?(:start))
    assert(@pp.lower?(:kj))
    refute(@pp.lower?(:A))
    refute(@pp.lower?(:HN))
  end

  def test_valid?
    assert(@pp.valid?([], :a))
    assert(@pp.valid?([:a], :a))
    assert(@pp.valid?([:a, :b], :a))
    assert(@pp.valid?([:b, :b], :a))
    assert(@pp.valid?([:b, :b], :B))
    assert(@pp.valid?([:b, :b, :c], :a))
    assert(@pp.valid?([:B, :B, :a], :a))
    assert(@pp.valid?([:B, :B, :B], :a))
    assert(@pp.valid?([:B, :B, :B, :a], :a))
    refute(@pp.valid?([:a, :a], :a))
    refute(@pp.valid?([:a, :b, :b], :a))
    refute(@pp.valid?([:a, :b, :b, :B, :B, :B], :a))
  end

  def test_read_graph
    assert_equal(
      {
        start: [:A, :b], A: [:c, :b, :end], c: [:A], b: [:A, :d, :end], d: [:b]
      },
      @pp.read_graph(INPUT)
    )
  end

  def test_follow_paths
    graphs = [
      [{ start: [:end] }, [[:start, :end]]],
      [{ start: [:A], A: [:end] }, [[:start, :A, :end]]],
      [
        { start: [:A], A: [:b, :end], b: [:A] },
        [[:start, :A, :b, :A, :end], [:start, :A, :end]]
      ]
    ]

    graphs.each do |graph, result|
      paths = []
      @pp.follow_paths(graph, :start, :end, [], paths)
      assert_equal(result, paths)
    end

    paths = []
    @pp.follow_paths(graphs[2][0], :start, :end, [], paths, part2: true)
    assert_equal(
      [
        [:start, :A, :b, :A, :b, :A, :end],
        [:start, :A, :b, :A, :end],
        [:start, :A, :end]
      ],
      paths
    )
  end

  def test_part1
    assert_equal(10, @pp.part1(@pp.read_graph(INPUT)))
  end

  def test_part2
    assert_equal(36, @pp.part2(@pp.read_graph(INPUT)))
  end
end
