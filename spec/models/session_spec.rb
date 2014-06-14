require 'rails_helper'

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
      session = Session.new(email: nil, password: "secret1")

      expect(session).to_not be_valid
      expect(session.errors.size).to eq(1)
      expect(session.errors[:email].size).to eq(1)
    end
    it "requires a password" do
      session = Session.new(email: "nick.desteffen@gmail.com", password: nil)

      expect(session).to_not be_valid
      expect(session.errors.size).to eq(1)
      expect(session.errors[:password].size).to eq(1)
    end
  end

  describe "persisted?" do
    it "should be false" do
      expect(Session.new).to_not be_persisted
    end
  end

  describe "authenticated?" do

    let!(:user) { FactoryGirl.create(:user, email: "nick.desteffen@gmail.com", password: "secret1") }

    it "returns true if the session's user's email and password matches the session" do
      session = Session.new(email: "nick.desteffen@gmail.com", password: "secret1")

      expect(session).to be_authenticated
    end
    it "returns false if the session's user's email doesn't match the session" do
      session = Session.new(email: "nick@gmail.com", password: "secret1")

      expect(session).to_not be_authenticated
    end
    it "returns false if the session's user's password doesn't match the session" do
      session = Session.new(email: "nick.desteffen@gmail.com", password: "secret2")

      expect(session).to_not be_authenticated
    end
  end

  describe "user" do
    it "returns the authenticated user" do
      user = FactoryGirl.create(:user, email: "nick.desteffen@gmail.com", password: "secret1")

      session = Session.new(email: "nick.desteffen@gmail.com", password: "secret1")

      expect(session).to be_authenticated
      expect(session.user).to eq(user)
    end
  end

end
