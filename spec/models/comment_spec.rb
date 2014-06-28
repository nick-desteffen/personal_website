require 'rails_helper'

describe Comment do

  describe "validations" do
    it "requires a name" do
      comment = FactoryGirl.build(:comment, name: nil)

      expect(comment).to_not be_valid
      expect(comment.errors.size).to eq(1)
      expect(comment.errors[:name].size).to eq(1)
    end
    it "requires a body" do
      comment = FactoryGirl.build(:comment, body: nil)

      expect(comment).to_not be_valid
      expect(comment.errors.size).to eq(1)
      expect(comment.errors[:body].size).to eq(1)
    end
    it "requires a valid email address if email is present" do
      comment = FactoryGirl.build(:comment, email: "nick")

      expect(comment).to_not be_valid
      expect(comment.errors.size).to eq(1)
      expect(comment.errors[:email].size).to eq(1)
    end
    it "requires a valid url if url is present" do
      comment = FactoryGirl.build(:comment, url: "google.com")

      expect(comment).to_not be_valid
      expect(comment.errors.size).to eq(1)
      expect(comment.errors[:url].size).to eq(1)
    end
    it "should be invalid if it is flagged as spam" do
      comment = FactoryGirl.build(:comment, url: "google.com")
      allow(comment).to receive(:spam?).and_return(true)

      expect(comment).to_not be_valid
      expect(comment.errors[:base].size).to eq(1)
    end
  end

  describe "generate_gravatar_hash" do
    it "is generated after create if email address is present" do
      comment = FactoryGirl.create(:comment, gravatar_hash: nil, email: "nick.desteffen@gmail.com")

      expect(comment.gravatar_hash).to_not be_nil
    end
    it "is not generated if email is not present" do
      comment = FactoryGirl.create(:comment, gravatar_hash: nil, email: nil)

      expect(comment.gravatar_hash).to be_nil
    end
  end

  describe "flag_spam!" do
    it "flags a comment as spam" do
      comment = FactoryGirl.create(:comment)
      allow(comment).to receive(:spam!).once
      allow(comment).to receive(:spam?).once.and_return(true)

      comment.flag_spam!

      expect(comment.reload).to be_spam_flag
    end
  end

  describe "not_spam" do
    it "only returns comments that haven't been flagged as spam" do
      spam = FactoryGirl.create(:comment, spam_flag: true)
      not_spam = FactoryGirl.create(:comment, spam_flag: false)

      comments = Comment.not_spam

      expect(comments).to include(not_spam)
      expect(comments).to_not include(spam)
    end
  end

  describe "preview" do
    it "builds a new comment record, sets the created_at and runs validations" do
      params = {body: "**Message**", name: "Nick", email: "nick.desteffen@gmail.com"}

      comment = Comment.preview(params)

      expect(comment.created_at).to_not be_nil
      expect(comment.gravatar_hash).to_not be_nil
      expect(comment).to be_new_record
    end
  end

  describe "notify_commenters" do
    let(:post) { FactoryGirl.create(:post) }
    it "should email any comment posters when a new comment is posted if they have requested to be notified" do
      comment1 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "commenter@gmail.com")
      ActionMailer::Base.deliveries.clear
      comment2 = FactoryGirl.create(:comment, post: post, new_comment_notification: true)

      expect(ActionMailer::Base.deliveries.size).to eq(2)
      recipients = ActionMailer::Base.deliveries.map(&:to).flatten

      expect(recipients.sort).to eq ["commenter@gmail.com", "nick.desteffen@gmail.com"]
    end
    it "should not send a person more than 1 email" do
      comment1 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "commenter@gmail.com")
      comment2 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "commenter@gmail.com")

      ActionMailer::Base.deliveries.clear
      comment3 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "commenter@gmail.com")

      expect(ActionMailer::Base.deliveries.size).to eq(2)
      recipients = ActionMailer::Base.deliveries.map(&:to).flatten

      expect(recipients.sort).to eq ["commenter@gmail.com", "nick.desteffen@gmail.com"]
    end
    it "should work with a comment that has a blank email address field" do
      comment1 = FactoryGirl.create(:comment, post: post, new_comment_notification: true, email: "")
      ActionMailer::Base.deliveries.clear

      comment2 = FactoryGirl.create(:comment, post: post)

      expect(ActionMailer::Base.deliveries.size).to eq(1)
      recipients = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(recipients.sort).to eq ["nick.desteffen@gmail.com"]
    end
  end

  describe "notify" do
    it "should return any comments where new_comment_notification is true" do
      comment1 = FactoryGirl.create(:comment, new_comment_notification: true)
      comment2 = FactoryGirl.create(:comment, new_comment_notification: false)

      notifications = Comment.notify

      expect(notifications.size).to eq(1)
      expect(notifications).to include(comment1)
      expect(notifications).to_not include(comment2)
    end
  end

end
