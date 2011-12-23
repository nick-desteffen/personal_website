require 'spec_helper'

describe SessionsController do
  
  describe "new" do
    it "has a session object" do
      get :new
      
      assigns(:session).should_not be_nil
    end
  end
  
  describe "create" do
    it "logs a user in" do
      user = FactoryGirl.create(:user, :password => "secret1")
      
      post :create, :session => {:email => user.email, :password => "secret1"}
      
      session[:user_id].should == user.id
      flash[:notice].should_not be_nil
      response.should redirect_to root_path
    end
    it "reloads the page if errors are present" do
      user = FactoryGirl.create(:user, :password => "secret1")
      
      post :create, :session => {:email => user.email, :password => "secret2"}
      
      session[:user_id].should == nil
      flash.now[:alert].should_not be_nil
      response.should render_template(:new)
    end
  end
  
  describe "destroy" do
    it "destroys the session" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      
      delete :destroy
      
      session[:user_id].should == nil
      flash[:notice].should_not be_nil
      response.should redirect_to root_path
    end
  end
  
end
