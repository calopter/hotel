require 'simplecov'
SimpleCov.start do
    add_filter 'test/' # Tests should not be counted toward coverage.
end

require 'minitest/pride'
require "minitest/autorun"
require 'minitest/skip_dsl'
# require "minitest/reporters"

# Minitest::Reporters.use!
# Minitest::Reporters::SpecReporter.new

require_relative '../lib/booker.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/date_range.rb'
require_relative '../lib/blocker.rb'
require_relative '../lib/block.rb'
