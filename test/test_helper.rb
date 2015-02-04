ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  class << self
    alias :context :describe
  end

  def authorizations_path
    Rails.configuration.x.registry_url + '/authorizations'
  end
end
