require 'rails_helper'

describe ProjectsController do

  describe "wisepatient" do
    it "should render" do
      get :wisepatient

      expect(response).to be_success
    end
  end

  describe "index" do
    it "should render" do
      get :index

      expect(response).to be_success
    end
  end

  describe "splash_surveys" do
    it "should render" do
      get :splash_surveys

      expect(response).to be_success
    end
  end

end
