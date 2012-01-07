require 'spec_helper'

describe ContactMessage do

  describe "validations" do
    it "requires an email address" do
      contact_message = FactoryGirl.build(:contact_message, :email => nil)
      
      contact_message.valid?.should == false
      contact_message.errors.size.should == 2
      contact_message.errors[:email].size.should == 2
    end
    it "requires a phone number between 9 & 10 digits" do
      contact_message = FactoryGirl.build(:contact_message, :phone_number => "123")
      
      contact_message.valid?.should == false
      contact_message.errors.size.should == 1
      contact_message.errors[:phone_number].size.should == 1
    end
    it "requires a name" do
      contact_message = FactoryGirl.build(:contact_message, :name => nil)
      
      contact_message.valid?.should == false
      contact_message.errors.size.should == 1
      contact_message.errors[:name].size.should == 1
    end
    it "requires a message" do
      contact_message = FactoryGirl.build(:contact_message, :message => nil)
      
      contact_message.valid?.should == false
      contact_message.errors.size.should == 1
      contact_message.errors[:message].size.should == 1
    end
    it "requires a valid email address" do
      contact_message = FactoryGirl.build(:contact_message, :email => "nick")
      
      contact_message.valid?.should == false
      contact_message.errors.size.should == 1
      contact_message.errors[:email].size.should == 1
    end
  end
  
  describe "sanitize_phone_number" do
    it "strips all non-numeric characters" do
      contact_message = FactoryGirl.create(:contact_message, :phone_number => "312-914-2333")
      
      contact_message.phone_number.should == "3129142333"
    end
  end
  
  describe "deliver_email_notification" do
    it "delivers an email after_create" do
      ActionMailer::Base.deliveries.clear
      contact_message = FactoryGirl.create(:contact_message)
      
      ActionMailer::Base.deliveries.size.should == 1
    end
  end
  
end
