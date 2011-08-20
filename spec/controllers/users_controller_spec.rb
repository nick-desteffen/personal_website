require 'spec_helper'

describe UsersController do
  render_views

  describe "new" do
    it "has a user object" do
      get :new
      
      assigns(:user).should_not be_nil
      response.should be_success
    end
  end
  
  describe "create" do
    it "creates a new user" do
      User.any_instance.stubs(:save).returns(true)
      
      post :create, :user => {}
      
      flash.notice.should_not be_nil
      response.should redirect_to root_path
    end
    it "reloads the page if errors are present" do
      User.any_instance.stubs(:save).returns(false)
      
      post :create, :user => {}
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:new)
    end
  end
  
end
