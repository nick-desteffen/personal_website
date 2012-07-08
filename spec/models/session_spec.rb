require 'spec_helper'

describe Session do
  include ActiveModel::Lint::Tests

  def model
    Session.new
  end

  describe "ActiveModel::Lint::Tests" do
    it "should be an ActiveModel compliant object" do
      test_to_key
      test_to_param
      test_to_partial_path
      test_persisted?
      test_model_naming
      test_errors_aref
    end
  end
  
  describe "validations" do
    it "requires an email" do
      session = Session.new(:email => nil, :password => "secret1")
      
      session.valid?.should == false
      session.errors.size.should == 1
      session.errors[:email].size.should == 1
    end
    it "requires a password" do
      session = Session.new(:email => "nick.desteffen@gmail.com", :password => nil)
      
      session.valid?.should == false
      session.errors.size.should == 1
      session.errors[:password].size.should == 1
    end
  end
  
  describe "persisted?" do
    it "should be false" do
      Session.new().persisted?.should == false
    end
  end
  
  describe "authenticated?" do
    before(:each) do
      @user = FactoryGirl.create(:user, :email => "nick.desteffen@gmail.com", :password => "secret1")
    end
    it "returns true if the session's user's email and password matches the session" do
      session = Session.new(:email => "nick.desteffen@gmail.com", :password => "secret1")
      
      session.authenticated?.should == true
    end
    it "returns false if the session's user's email doesn't match the session" do
      session = Session.new(:email => "nick@gmail.com", :password => "secret1")
      
      session.authenticated?.should == false
    end
    it "returns false if the session's user's password doesn't match the session" do
      session = Session.new(:email => "nick.desteffen@gmail.com", :password => "secret2")
      
      session.authenticated?.should == false      
    end
  end
  
  describe "user" do
    it "returns the authenticated user" do
      user = FactoryGirl.create(:user, :email => "nick.desteffen@gmail.com", :password => "secret1")

      session = Session.new(:email => "nick.desteffen@gmail.com", :password => "secret1")
      
      session.authenticated?.should == true
      session.user.should == user
    end
  end
  
end