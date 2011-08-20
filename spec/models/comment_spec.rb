require 'spec_helper'

describe Comment do

  describe "validations" do
    it "requires a name" do
      comment = FactoryGirl.build(:comment, :name => nil)
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:name].size.should == 1
    end
    it "requires a body" do
      comment = FactoryGirl.build(:comment, :body => nil)
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:body].size.should == 1
    end
    it "requires a valid email address if email is present" do
      comment = FactoryGirl.build(:comment, :email => "nick")
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:email].size.should == 1
    end
    it "requires a valid url if url is present" do
      comment = FactoryGirl.build(:comment, :url => "google.com")
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:url].size.should == 1
    end
  end
  
  describe "generate_gravatar_hash" do
    it "is generated after create if email address is present" do
      comment = FactoryGirl.create(:comment, :gravatar_hash => nil, :email => "nick.desteffen@gmail.com")
      
      comment.gravatar_hash.should_not == nil
    end
    it "is not generated if email is not present" do
      comment = FactoryGirl.create(:comment, :gravatar_hash => nil, :email => nil)
      
      comment.gravatar_hash.should == nil
    end
  end
  
end
