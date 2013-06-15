class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery with: :exception

  class_attribute :active_tab

  def self.active_tab(tab=nil)
    self.active_tab = tab
  end

end
