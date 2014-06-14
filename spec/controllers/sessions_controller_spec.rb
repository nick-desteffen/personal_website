require 'rails_helper'

describe SessionsController do

  describe "new" do
    it "has a session object" do
      get :new

      expect(assigns(:session)).to_not be_nil
    end
  end

  describe "create" do
    it "logs a user in" do
      user = FactoryGirl.create(:user, password: "secret1")

      post :create, session: {email: user.email, password: "secret1"}

      expect(session[:user_id]).to eq(user.id)
      expect(flash[:notice]).to_not be_nil
      expect(response).to redirect_to admin_index_path
    end
    it "reloads the page if errors are present" do
      user = FactoryGirl.create(:user, password: "secret1")

      post :create, session: {email: user.email, password: "secret2"}

      expect(session[:user_id]).to be_nil
      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template(:new)
    end
  end

  describe "destroy" do
    it "destroys the session" do
      user = FactoryGirl.create(:user)
      login_as(user)

      delete :destroy

      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to_not be_nil
      expect(response).to redirect_to root_path
    end
  end

end
