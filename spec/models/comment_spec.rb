require 'spec_helper'

describe Comment do

  describe "validations" do
    it "requires a name" do
      comment = FactoryGirl.build(:comment, :name => nil)
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:name].size.should == 1
    end
    it "requires a body" do
      comment = FactoryGirl.build(:comment, :body => nil)
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:body].size.should == 1
    end
    it "requires a valid email address if email is present" do
      comment = FactoryGirl.build(:comment, :email => "nick")
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:email].size.should == 1
    end
    it "requires a valid url if url is present" do
      comment = FactoryGirl.build(:comment, :url => "google.com")
      
      comment.valid?.should == false
      comment.errors.size.should == 1
      comment.errors[:url].size.should == 1
    end
    it "should be invalid if it is flagged as spam" do
      comment = FactoryGirl.build(:comment, :url => "google.com")
      comment.stubs(:spam?).returns(true)

      comment.valid?.should == false
      comment.errors[:base].include?("Sorry, but this comment appears to be spam. If it is not spam please use the contact form.").should == true
    end
  end
  
  describe "generate_gravatar_hash" do
    it "is generated after create if email address is present" do
      comment = FactoryGirl.create(:comment, :gravatar_hash => nil, :email => "nick.desteffen@gmail.com")
      
      comment.gravatar_hash.should_not == nil
    end
    it "is not generated if email is not present" do
      comment = FactoryGirl.create(:comment, :gravatar_hash => nil, :email => nil)
      
      comment.gravatar_hash.should == nil
    end
  end
  
  describe "flag_spam!" do
    it "flags a comment as spam" do
      comment = FactoryGirl.create(:comment)
      comment.expects(:spam!).once
      
      comment.flag_spam!
      
      comment.spam_flag?.should == true
    end
  end
  
  describe "not_spam" do
    it "only returns comments that haven't been flagged as spam" do
      spam = FactoryGirl.create(:comment, :spam_flag => true)
      not_spam = FactoryGirl.create(:comment, :spam_flag => false)
      
      comments = Comment.not_spam
      
      comments.include?(not_spam).should == true
      comments.include?(spam).should == false
    end
  end

  describe "preview" do
    it "builds a new comment record, sets the created_at and runs validations" do
      params = {body: "**Message**", name: "Nick", email: "nick.desteffen@gmail.com"}

      comment = Comment.preview(params)

      comment.created_at.should_not be_nil
      comment.gravatar_hash.should_not be_nil
      comment.new_record?.should == true
    end
  end

  describe "notify_commenters" do
    it "should email any comment posters when a new comment is posted if they have requested to be notified" do
      ActionMailer::Base.deliveries.clear
      post = FactoryGirl.create(:post)
      comment1 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "commenter@gmail.com")
      comment2 = FactoryGirl.create(:comment, post: post, new_comment_notification: true)
      
      ActionMailer::Base.deliveries.size.should == 3
      recipients = ActionMailer::Base.deliveries.map(&:to).flatten

      recipients.sort.should == ["commenter@gmail.com", "nick.desteffen@gmail.com", "nick.desteffen@gmail.com"]
    end
  end

  describe "notify" do
    it "should return any comments where new_comment_notification is true and email is present" do
      pending
    end
  end
    
end
