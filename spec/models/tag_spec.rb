require 'spec_helper'

describe Tag do

  describe "validations" do
    it "requires a name" do
      tag = FactoryGirl.build(:tag, :name => nil)

      tag.valid?.should == false
      tag.errors.size.should == 1
      tag.errors[:name].size.should == 1
    end
  end

  describe "alphabetized" do
    it "orders tags by name" do
      t_tag = FactoryGirl.create(:tag, :name => "t")
      a_tag = FactoryGirl.create(:tag, :name => "a")
      z_tag = FactoryGirl.create(:tag, :name => "z")
      r_tag = FactoryGirl.create(:tag, :name => "r")

      tags = Tag.alphabetized.load
      tags[0].should == a_tag
      tags[1].should == r_tag
      tags[2].should == t_tag
      tags[3].should == z_tag
    end
  end

end
