require 'spec_helper'

describe RelatedLink do

  describe "validations" do
    it "requires a url" do
      related_link = FactoryGirl.build(:related_link, url: nil)

      expect(related_link).to_not be_valid
      expect(related_link.errors.size).to eq(1)
      expect(related_link.errors[:url].size).to eq(1)
    end
    it "requires a fully qualified url" do
      related_link = FactoryGirl.build(:related_link, url: "google.com")

      expect(related_link).to_not be_valid
      expect(related_link.errors.size).to eq(1)
      expect(related_link.errors[:url].size).to eq(1)
    end
  end

  describe "title" do
    it "should return the title if it is present" do
      related_link = FactoryGirl.build(:related_link, title: "Google", url: "http://www.google.com")

      expect(related_link.title).to eq("Google")
    end
    it "should return the url if title is blank" do
      related_link = FactoryGirl.build(:related_link, title: "", url: "http://www.google.com")

      expect(related_link.title).to eq("http://www.google.com")
    end
  end

end
