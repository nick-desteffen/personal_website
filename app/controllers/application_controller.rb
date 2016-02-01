class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  class_attribute :active_tab

  def self.active_tab(tab=nil)
    self.active_tab = tab
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
