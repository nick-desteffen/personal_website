require 'spec_helper'

describe PostsHelper do
  
  describe "gravatar_image" do
    it "returns nothing if the gravatar hash is blank" do
      image = gravatar_image("")
      
      image.should == nil
    end
    it "returns an image tag with the gravatar hash if it isn't blank" do
      image = gravatar_image("XXXXX")
      
      image.should == "<img alt=\"\" src=\"http://www.gravatar.com/avatar/XXXXX?size=75\" title=\"\" />"
    end
  end
  
  describe "comment_name" do
    it "returns the name if no url is present in the comment" do
      comment = FactoryGirl.create(:comment, :name => "Nick", :url => "http://nick-desteffen.net")
      
      comment_name = helper.comment_name(comment)

      comment_name.should =~ /nick-desteffen.net/
      comment_name.should =~ /Nick/
    end
    it "returns the name as a link if the url is present in the comment" do
      comment = FactoryGirl.create(:comment, :name => "Nick", :url => nil)
      
      comment_name = helper.comment_name(comment)
      
      comment_name.should_not =~ /nick-desteffen.net/
      comment_name.should =~ /Nick/
    end
  end
  
  describe "flag_spam_link" do
    it "returns noting unless there is a current_user" do
      helper.stubs(:current_user).returns(nil)
      comment = FactoryGirl.create(:comment)
      
      helper.flag_spam_link(comment).should == nil
    end
    it "returns a link to flag the content as spam" do
      user = FactoryGirl.create(:user)
      helper.stubs(:current_user).returns(user)
      
      comment = FactoryGirl.create(:comment)
      
      helper.flag_spam_link(comment).should =~ /Flag Spam/
    end
  end
  
end
