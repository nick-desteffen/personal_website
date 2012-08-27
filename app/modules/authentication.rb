module Authentication
  extend ActiveSupport::Concern    
  
  included do
    helper_method :current_user
  end
    
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  private
  
  def login_required
    if current_user.nil?
      session[:return_to_path] = request.url
      redirect_to root_path, :alert => "Unauthorized!"
    end
  end
  
  def redirect_back_or_default(default=:back, flash={})
    if session[:return_to_path].present?
      return_to_path = session[:return_to_path]
      session[:return_to_path] = nil
      redirect_to return_to_path, flash
    else
      redirect_to default, flash
    end
  end
  
  def logout
    reset_session
  end
  
  def login(user)
    session[:user_id] = user.id
  end
    
end