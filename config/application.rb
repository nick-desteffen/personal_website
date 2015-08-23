require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module PersonalWebsite
  class Application < Rails::Application
    config.autoload_paths += %W(#{Rails.root}/lib)

    config.time_zone = 'Central Time (US & Canada)'

    I18n.enforce_available_locales = false

    config.encoding = "utf-8"
    config.active_support.escape_html_entities_in_json = true
    config.active_record.schema_format = :sql

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end

    ActionMailer::Base.prepend_view_path "#{Rails.root}/app/mailer_views"
    ActionMailer::Base.smtp_settings = {
      address:        "smtp.sendgrid.net",
      port:           "25",
      authentication: :plain,
      user_name:      Rails.application.secrets.sendgrid.username,
      password:       Rails.application.secrets.sendgrid.password,
      domain:         Rails.application.secrets.sendgrid.domain
    }

    config.email_validation_regex = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  end
end
