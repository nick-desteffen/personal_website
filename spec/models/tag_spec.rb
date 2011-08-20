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
  
end
