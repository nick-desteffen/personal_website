require 'spec_helper'

describe ContactMessage do

  describe "validations" do
    it "requires an email address" do
      contact_message = FactoryGirl.build(:contact_message, email: nil)

      expect(contact_message).to_not be_valid
      expect(contact_message.errors.size).to eq(2)
      expect(contact_message.errors[:email].size).to eq(2)
    end
    it "requires a phone number between 9 & 10 digits" do
      contact_message = FactoryGirl.build(:contact_message, phone_number: "123")

      expect(contact_message).to_not be_valid
      expect(contact_message.errors.size).to eq(1)
      expect(contact_message.errors[:phone_number].size).to eq(1)
    end
    it "requires a name" do
      contact_message = FactoryGirl.build(:contact_message, name: nil)

      expect(contact_message).to_not be_valid
      expect(contact_message.errors.size).to eq(1)
      expect(contact_message.errors[:name].size).to eq(1)
    end
    it "requires a message" do
      contact_message = FactoryGirl.build(:contact_message, message: nil)

      expect(contact_message).to_not be_valid
      expect(contact_message.errors.size).to eq(1)
      expect(contact_message.errors[:message].size).to eq(1)
    end
    it "requires a valid email address" do
      contact_message = FactoryGirl.build(:contact_message, email: "nick")

      expect(contact_message).to_not be_valid
      expect(contact_message.errors.size).to eq(1)
      expect(contact_message.errors[:email].size).to eq(1)
    end
  end

  describe "sanitize_phone_number" do
    it "strips all non-numeric characters" do
      contact_message = FactoryGirl.create(:contact_message, phone_number: "312-914-2333")

      expect(contact_message.phone_number).to eq("3129142333")
    end
  end

  describe "deliver_email_notification" do
    it "delivers an email after_create" do
      ActionMailer::Base.deliveries.clear
      contact_message = FactoryGirl.create(:contact_message)

      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

end
