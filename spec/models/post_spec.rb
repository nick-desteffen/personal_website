require 'spec_helper'

describe Post do

  describe "validations" do
    it "requires a body" do
      post = FactoryGirl.build(:post, body: nil)

      expect(post).to_not be_valid
      expect(post.errors.size).to eq(1)
      expect(post.errors[:body].size).to eq(1)
    end
    it "requires a title" do
      post = FactoryGirl.build(:post, title: nil)

      expect(post).to_not be_valid
      expect(post.errors.size).to eq(1)
      expect(post.errors[:title].size).to eq(1)
    end
  end

  describe "published" do
    it "returns only posts where published_at is in the hpast" do
      published_post = FactoryGirl.create(:post, published_at: 1.week.ago)
      unpublished_post = FactoryGirl.create(:post, published_at: nil)
      future_post = FactoryGirl.create(:post, published_at: 1.week.from_now)

      posts = Post.published

      expect(posts.size).to eq(1)
      expect(posts).to include(published_post)
      expect(posts).to_not include(unpublished_post)
      expect(posts).to_not include(future_post)
    end
  end

end
