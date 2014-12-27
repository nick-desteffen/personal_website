require 'rails_helper'

describe PostsHelper do

  describe "gravatar_image" do
    it "returns nothing if the gravatar hash is blank" do
      image = gravatar_image("")

      expect(image).to be_nil
    end
    it "returns an image tag with the gravatar hash if it isn't blank" do
      image = gravatar_image("XXXXX")

      expect(image).to eq "<img alt=\"\" title=\"\" src=\"http://www.gravatar.com/avatar/XXXXX?size=75\" />"
    end
  end

  describe "comment_name" do
    it "returns the name if no url is present in the comment" do
      comment = FactoryGirl.create(:comment, name: "Nick", url: "http://nickdesteffen.com")

      comment_name = helper.comment_name(comment)

      expect(comment_name).to match /nickdesteffen.com/
      expect(comment_name).to match /Nick/
    end
    it "returns the name as a link if the url is present in the comment" do
      comment = FactoryGirl.create(:comment, name: "Nick", url: nil)

      comment_name = helper.comment_name(comment)

      expect(comment_name).to_not match /nickdesteffen.com/
      expect(comment_name).to match /Nick/
    end
  end

  describe "admin_comment_links" do
    it "returns noting unless there is a current_user" do
      comment = FactoryGirl.create(:comment)

      expect(helper.admin_comment_links(comment, nil)).to be_nil
    end
    it "returns nothing if the comment hasn't been saved" do
      expect(helper.admin_comment_links(Comment.new, nil)).to be_nil
    end
    it "returns a link to flag the comment as spam, edit the comment, and destroy the comment" do
      user = FactoryGirl.create(:user)

      comment = FactoryGirl.create(:comment)

      expect(helper.admin_comment_links(comment, user)).to match /Flag Spam/
      expect(helper.admin_comment_links(comment, user)).to match /Edit/
      expect(helper.admin_comment_links(comment, user)).to match /Destroy/
    end
  end

  describe "format_comment" do
    it "returns an empty string if the string passed in is nil" do
      expect(helper.format_comment(nil)).to be_nil
    end
    it "formats markdown" do
      expect(helper.format_comment("**Bold**")).to eq("<p><strong>Bold</strong></p>\n")
    end
  end

  describe "teaser" do
    it "should strip all the html tags" do
      post = Post.new(body: "<h1>Title</h1> <p>The quick brown fox jumped over the lazy dog</p>")

      expect(helper.teaser(post)).to eq "Title The quick brown fox jumped over the lazy dog"
    end
    it "should replace &ndash; with - " do
      post = Post.new(body: "<h1>Title</h1> <p>The quick brown fox jumped over the lazy dog</p> <h2>Second Title &ndash; Welcome!</h2>")

      expect(helper.teaser(post)).to eq "Title The quick brown fox jumped over the lazy dog Second Title – Welcome!"
    end
  end

  describe "tags" do
    it "should return the tags on the post sorted and joined" do
      post = FactoryGirl.build(:post, tags: ["ruby", "array", "rails", "postgres"])

      expect(helper.tags(post)).to eq("array, postgres, rails, ruby")
    end
  end

end
