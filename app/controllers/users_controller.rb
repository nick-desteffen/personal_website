class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Thanks for signing up!"
    else
      flash.now.alert = "There was an error creating your account."
      render :action => :new
    end
  end
  
end
