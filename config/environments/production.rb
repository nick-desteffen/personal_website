PersonalWebsite::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.action_dispatch.x_sendfile_header = nil
  config.log_level = :info
  config.assets.initialize_on_precompile = false
  config.action_mailer.default_url_options = { :host => 'www.nickdesteffen.com' }
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.middleware.use ExceptionNotifier, sender_address: 'nick.desteffen@gmail.com', exception_recipients: 'nick.desteffen@gmail.com'
end
