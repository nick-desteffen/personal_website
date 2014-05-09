require 'spec_helper'

describe ApplicationController do

  let(:user) { FactoryGirl.create(:user) }

  describe "current_user" do
    it "returns the currently logged in user" do
      session[:user_id] = user.id

      expect(controller.current_user).to eq(user)
    end
    it "returns nil if no user is logged in" do
      expect(controller.current_user).to be_nil
    end
  end

  describe "login" do
    it "sets the user's id in the session" do
      controller.send(:login, user)

      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "logout" do
    it "sets the user's id in session to be nil" do
      controller.send(:login, user)

      controller.send(:logout)

      expect(session[:user_id]).to be_nil
    end
  end

  describe "login_required" do

    controller do
      def index
        login_required
      end
    end

    it "redirects to the homepage, stores the original destination and has an alert message if there is no user" do
      routes.draw { get "index" => "anonymous#index" }
      allow(controller).to receive(:root_path).and_return("/")

      get :index

      expect(response).to redirect_to root_path
      expect(session[:return_to_path]).to_not be_nil
      expect(flash[:alert]).to_not be_nil
    end
  end

  describe "redirect_back_or_default" do

    controller do
      def index
        redirect_back_or_default(root_path)
      end
    end

    it "redirects back to where the user was coming from" do
      routes.draw { get "index" => "anonymous#index" }
      allow(controller).to receive(:root_path).and_return("/")
      session[:return_to_path] = "/blog"

      get :index

      expect(response).to redirect_to "/blog"
    end
    it "redirects to a default place if no destination was set" do
      routes.draw { get "index" => "anonymous#index" }
      allow(controller).to receive(:root_path).and_return("/")

      session[:return_to_path] = nil

      get :index

      expect(response).to redirect_to root_path
    end
  end

end
