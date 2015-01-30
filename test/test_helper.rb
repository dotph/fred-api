ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

require 'minitest/reporters'

Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new,
  Minitest::Reporters::JUnitReporter.new
]

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def authorizations_path
    Rails.configuration.x.registry_url + '/authorizations'
  end
end
