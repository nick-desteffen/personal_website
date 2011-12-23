require 'spec_helper'

describe HomeController do
  
  describe "index" do
    it "renders" do
      get :index
      
      response.should be_success
    end
  end

  describe "about" do
    it "renders" do
      get :about
      
      response.should be_success
    end
  end

end
