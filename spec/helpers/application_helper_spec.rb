require 'rails_helper'

describe ApplicationHelper do

  describe "format_timestamp" do
    it "and_return nothing if the timestamp is blank" do
      expect(helper.format_timestamp(nil)).to be_nil
    end
    it "formats the timestamp" do
      time = Time.mktime(2011, 8, 20, 8, 30, 30)
      expect(helper.format_timestamp(time)).to eq("08/20/2011 08:30am")
    end
  end

  describe "error_messages_for" do
    it "builds out error messages with the object" do
      contact_message = FactoryGirl.build(:contact_message, name: nil)
      contact_message.valid?

      error_messages = helper.error_messages_for(contact_message)

      expect(error_messages).to_not be_nil
    end
  end

  describe "flash_messages" do
    it "and_return nothing if there is no flash" do
      allow(helper).to receive(:flash).and_return({})

      expect(helper.flash_messages).to be_nil
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {error: "Something went wrong"}
      allow(helper).to receive(:flash).and_return(flash_messages)

      expect(helper.flash_messages).to match /error/
      expect(helper.flash_messages).to match /Something went wrong/
      expect(helper.flash_messages).to match /24x24\/error.png/
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {notice: "Something went right"}
      allow(helper).to receive(:flash).and_return(flash_messages)

      expect(helper.flash_messages).to match /notice/
      expect(helper.flash_messages).to match /Something went right/
      expect(helper.flash_messages).to match /24x24\/error.png/
    end
  end

  describe "navigation_link" do
    before do
      allow(helper).to receive(:controller).and_return(ApplicationController.new)
    end
    it "has no class if the active_tab key doesn't match the key passed in" do
      link = helper.navigation_link("Contact", root_path, :contact)

      expect(link).to eq("<a class=\"\" href=\"/\">Contact</a>")
    end
    it "has the active class if the active_tab key matches the key passed in" do
      allow(helper.controller).to receive(:active_tab).and_return(:contact)

      link = helper.navigation_link("Contact", root_path, :contact)

      expect(link).to eq("<a class=\"active\" href=\"/\">Contact</a>")
    end
  end

  describe "button" do
    it "and_return a button tag with the class button" do
      expect(helper.button("Save")).to match /button/
      expect(helper.button("Save")).to match /Save/
      expect(helper.button("Save")).to match /class="button"/
    end
  end

  describe "page_title" do
    before do
      allow(helper).to receive(:controller).and_return(ApplicationController.new)
    end
    it "and_return the page title in @page_title" do
      @page_title = "Test"

      expect(helper.page_title).to eq("Test | Nick DeSteffen")
    end
    it "and_return the active tab value if it is present" do
      allow(helper.controller).to receive(:active_tab).and_return(:contact)

      expect(helper.page_title).to eq("Contact | Nick DeSteffen")
    end
    it "and_return Nick DeSteffen if nothing else is present" do
      expect(helper.page_title).to eq("Nick DeSteffen")
    end
  end

end

