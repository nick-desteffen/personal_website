require 'spec_helper'

describe CommentsController do

  describe "create" do
    it "creates a new comment" do
      existing_post = FactoryGirl.create(:post)
      existing_comment = FactoryGirl.create(:comment, :post => existing_post)
      Comment.any_instance.stubs(:save).returns(true)
      
      post :create, :post_id => existing_post.id, :comment => {}
      
      flash[:notice].should_not be_nil
      response.should redirect_to(blog_post_path(existing_post))
    end
    it "reloads the page if errors are present" do
      existing_post = FactoryGirl.create(:post)
      existing_comment = FactoryGirl.create(:comment, :post => existing_post)
      Comment.any_instance.stubs(:save).returns(false)
      
      post :create, :post_id => existing_post, :comment => {}
      
      assigns(:comments).size.should == 1
      flash.now[:alert].should_not be_nil
      response.should render_template("posts/show")
    end
  end

  describe "flag_spam" do
    it "should update a comment's spam flag" do
      user = FactoryGirl.create(:user)
      login_as user
      comment = FactoryGirl.create(:comment, :spam_flag => false)
      
      post :flag_spam, :comment_id => comment.id, :format => "js"
      
      assigns(:comment).should == comment
      assigns(:comment).spam_flag?.should == true
      response.should be_success
    end
  end

  describe "edit" do
    it "has the requested comment" do
      user = FactoryGirl.create(:user)
      login_as user
      comment = FactoryGirl.create(:comment)

      get :edit, post_id: comment.post_id, comment_id: comment.id

      assigns(:comment).should == comment
    end
    it "requires a user be logged in" do
      comment = FactoryGirl.create(:comment)

      get :edit, post_id: comment.post_id, comment_id: comment.id

      response.should redirect_to(root_path)
      flash.alert.should_not be_nil
    end
  end

  describe "update" do
    it "updates the comment" do
      user = FactoryGirl.create(:user)
      login_as user
      comment = FactoryGirl.create(:comment, body: "Old Body")

      put :update, post_id: comment.post_id, comment_id: comment.id, comment: {body: "New Body"}

      assigns(:comment).body.should == "New Body"
      response.should redirect_to blog_post_path(comment.post)
    end
  end

  describe "preview" do
    it "builds a comment to preview" do
      post :preview, comment: {}, format: "js"

      assigns(:comment).should_not be_nil
      assigns(:comment).new_record?.should == true
      response.should be_success
    end
  end

end
