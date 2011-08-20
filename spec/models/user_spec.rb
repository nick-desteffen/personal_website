require 'spec_helper'

describe User do
  
  describe "validations" do
    it "requires a unique email" do
      user = FactoryGirl.create(:user, :email => "nick.desteffen@gmail.com")
      
      new_user = FactoryGirl.build(:user, :email => "nick.desteffen@gmail.com")
      
      new_user.valid?.should == false
      new_user.errors.size.should == 1
      new_user.errors[:email].size.should == 1
    end
    it "should have a correctly formatted email" do
      new_user = FactoryGirl.build(:user, :email => "nick.desteffen")
      
      new_user.valid?.should == false
      new_user.errors.size.should == 1
      new_user.errors[:email].size.should == 1
    end
  end
  
  describe "full_name" do
    it "should concatinate first and last names" do
      user = FactoryGirl.build(:user, :first_name => "Nick", :last_name => "DeSteffen")
      
      user.full_name.should == "Nick DeSteffen"
    end
  end
  
end
