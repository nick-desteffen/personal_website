class ApplicationController < ActionController::Base
  protect_from_forgery
  
  class_attribute :active_tab

  def self.active_tab(tab=nil)
    self.active_tab = tab
  end
    
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def login_required
    if current_user.nil?
      redirect_to root_path, :alert => "Unauthorized!"
    end
  end
  
end
