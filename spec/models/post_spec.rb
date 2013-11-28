require 'spec_helper'

describe Post do

  describe "validations" do
    it "requires a body" do
      post = FactoryGirl.build(:post, :body => nil)

      post.valid?.should == false
      post.errors.size.should == 1
      post.errors[:body].size.should == 1
    end
    it "requires a title" do
      post = FactoryGirl.build(:post, :title => nil)

      post.valid?.should == false
      post.errors.size.should == 1
      post.errors[:title].size.should == 1
    end
  end

  describe "published" do
    it "returns only posts where published_at is in the hpast" do
      published_post = FactoryGirl.create(:post, :published_at => 1.week.ago)
      unpublished_post = FactoryGirl.create(:post, :published_at => nil)
      future_post = FactoryGirl.create(:post, published_at: 1.week.from_now)

      posts = Post.published

      posts.size.should == 1
      posts.include?(published_post).should == true
      posts.include?(unpublished_post).should == false
      posts.include?(future_post).should == false
    end
  end

end
