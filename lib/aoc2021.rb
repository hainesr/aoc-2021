# frozen_string_literal: true

# Advent of Code 2021
#
# Robert Haines
#
# Public Domain

require 'rubygems'
require 'bundler/setup'

require 'aoc2021/day'

module AOC2021
  INPUT_DIR = ::File.expand_path('../etc', __dir__)

  DAY_MAP = [
    nil, # There is no day zero!

  ].freeze

  def self.class_from_day(day)
    class_name = day.split('_').map(&:capitalize).join
    class_path = "AOC2021::#{class_name}"
    class_path.split('::').reduce(Object) { |o, c| o.const_get c }
  end
end