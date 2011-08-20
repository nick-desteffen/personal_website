require 'spec_helper'

describe ApplicationHelper do
  
  describe "format_timestamp" do
    it "returns nothing if the timestamp is blank" do
      helper.format_timestamp(nil).should == nil
    end
    it "formats the timestamp" do
      helper.format_timestamp(Time.mktime(2011, 8, 20, 8, 30, 30)).should == "08/20/2011 08:30am"
    end
  end
  
  describe "error_messages_for" do
    it "renders the error messages partial with the object" do
      contact_message = FactoryGirl.build(:contact_message, :name => nil)
      
      response.expects(:render).with("shared/error_messages", {:object => contact_message}).once
      
      error_messages = helper.error_messages_for(contact_message)
    end
  end
  
  describe "navigation_class" do
    before(:each) do
      helper.stubs(:controller).returns(ApplicationController.new)
    end
    it "returns nothing if there is no active_tab defined" do
      helper.navigation_class(:contact).should == ""
    end
    it "returns 'active' if the controller's active_tab is equal to the navigation_key" do
      helper.controller.stubs(:active_tab).returns(:contact)
      
      helper.navigation_class(:contact).should == "active"
    end
    it "returns nothing if the active_tab is not equal to the navigation_key" do
      helper.controller.stubs(:active_tab).returns(:contact)
      
      helper.navigation_class(:blog).should == ""
    end
  end
    
  describe "button" do
    it "returns a button tag with the class button" do
      helper.button("Save").should =~ /button/
      helper.button("Save").should =~ /Save/
      helper.button("Save").should =~ /class="button"/
    end
  end
    
  describe "page_title" do
    before(:each) do
      helper.stubs(:controller).returns(ApplicationController.new)
    end
    it "returns the page title in @page_title" do
      @page_title = "Test"
      
      helper.page_title.should == "Test | Nick DeSteffen"
    end
    it "returns the active tab value if it is present" do
      helper.controller.stubs(:active_tab).returns(:contact)
      
      helper.page_title.should == "Contact | Nick DeSteffen"
    end
    it "returns Nick DeSteffen if nothing else is present" do
      helper.page_title.should == "Nick DeSteffen"
    end
  end
    
  
  describe "link_to_remove_fields" do
    pending
  end
  
  describe "link_to_add_fields" do
    pending
  end
  
end

