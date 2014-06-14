require 'rails_helper'

describe User do

  describe "validations" do
    it "requires a unique email" do
      user = FactoryGirl.create(:user, email: "nick.desteffen@gmail.com")

      new_user = FactoryGirl.build(:user, email: "nick.desteffen@gmail.com")

      expect(new_user).to_not be_valid
      expect(new_user.errors.size).to eq(1)
      expect(new_user.errors[:email]).to eq(["has already been taken"])
    end
    it "should have a correctly formatted email" do
      new_user = FactoryGirl.build(:user, email: "nick.desteffen")

      expect(new_user).to_not be_valid
      expect(new_user.errors.size).to eq(1)
      expect(new_user.errors[:email].size).to eq(1)
    end
  end

  describe "full_name" do
    it "should concatinate first and last names" do
      user = FactoryGirl.build(:user, first_name: "Nick", last_name: "DeSteffen")

      expect(user.full_name).to eq("Nick DeSteffen")
    end
  end

end
