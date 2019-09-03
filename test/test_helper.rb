require 'simplecov'
SimpleCov.start do
    add_filter 'test/' # Tests should not be counted toward coverage.
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/booker.rb'
require_relative '../lib/reservation.rb'
