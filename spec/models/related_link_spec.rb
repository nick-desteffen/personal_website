require 'spec_helper'

describe RelatedLink do
  
  describe "validations" do
    it "requires a url" do
      related_link = FactoryGirl.build(:related_link, :url => nil)

      related_link.valid?.should == false
      related_link.errors.size.should == 1
      related_link.errors[:url].size.should == 1
    end
    it "requires a fully qualified url" do
      related_link = FactoryGirl.build(:related_link, :url => "google.com")
      
      related_link.valid?.should == false
      related_link.errors.size.should == 1
      related_link.errors[:url].size.should == 1
    end
  end
  
  describe "title" do
    it "should return the title if it is present" do
      related_link = FactoryGirl.build(:related_link, :title => "Google", :url => "http://www.google.com")
      
      related_link.title.should == "Google"
    end
    it "should return the url if title is blank" do
      related_link = FactoryGirl.build(:related_link, :title => "", :url => "http://www.google.com")
      
      related_link.title.should == "http://www.google.com"
    end
  end
  
end
