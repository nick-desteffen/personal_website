require 'spec_helper'

describe ContactMessagesController do
  
  describe "new" do
    it "has a contact_message object" do
      get :new
      
      assigns(:contact_message).should_not be_nil
      response.should be_success
    end
  end
  
  describe "create" do
    it "creates a new contact message" do
      post :create, contact_message: FactoryGirl.attributes_for(:contact_message)
      
      flash.notice.should_not be_nil
      response.should redirect_to root_path
    end
    it "reloads the page if errors are present" do      
      post :create, contact_message: {message: ""}
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:new)
    end
  end
  
end
