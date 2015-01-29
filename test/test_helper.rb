ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'

require 'minitest/reporters'

Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new,
  Minitest::Reporters::JUnitReporter.new
]

class ActiveSupport::TestCase
end
