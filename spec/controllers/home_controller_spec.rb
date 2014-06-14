require 'rails_helper'

describe HomeController do

  describe "index" do
    it "renders" do
      get :index

      expect(response).to be_success
    end
  end

  describe "about" do
    it "renders" do
      get :about

      expect(response).to be_success
    end
  end

end
