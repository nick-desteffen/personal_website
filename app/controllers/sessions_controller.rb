class SessionsController < ApplicationController
  
  def new
    @session = Session.new
  end
  
  def create
    @session = Session.new(params[:session])
    if @session.valid? && @session.authenticated?
      session[:user_id] = @session.user.id
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :action => :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Logged out!"
  end
  
end
