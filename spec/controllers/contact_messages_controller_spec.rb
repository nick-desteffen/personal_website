require 'spec_helper'

describe ContactMessagesController do

  describe "new" do
    it "has a contact_message object" do
      get :new

      expect(assigns(:contact_message)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "create" do
    it "creates a new contact message" do
      post :create, contact_message: FactoryGirl.attributes_for(:contact_message)

      expect(flash.notice).to_not be_nil
      expect(response).to redirect_to root_path
    end
    it "reloads the page if errors are present" do
      post :create, contact_message: {message: ""}

      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template(:new)
    end
    it "shouldn't throw an exeption for invalid byte sequence errors" do
      message = "nike japan\r\n\xA5ʥ\xA4\xA5\xADֱ\x86ӵ\xEA"

      post :create, contact_message: FactoryGirl.attributes_for(:contact_message, message: message)

      expect(response).to be_success
      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template(:new)
    end
  end

end
