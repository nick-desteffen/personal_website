ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'mocha'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha
  config.render_views
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.order = :random

  config.before do
    Comment.any_instance.stubs(:spam?).returns(false)
  end
  
end

def login_as(user)
  session[:user_id] = user.id
end