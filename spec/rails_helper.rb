ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.render_views
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.infer_spec_type_from_file_location!

  config.before do
    allow_any_instance_of(Comment).to receive(:spam?).and_return(false)
    allow_any_instance_of(Comment).to receive(:spam!).and_return(true)
    allow_any_instance_of(ContactMessage).to receive(:spam?).and_return(false)
    allow_any_instance_of(ContactMessage).to receive(:spam!).and_return(true)
  end
end

def login_as(user)
  session[:user_id] = user.id
end
