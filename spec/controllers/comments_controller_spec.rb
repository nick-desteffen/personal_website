require 'spec_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user) }

  describe "create" do

    let!(:existing_post) { FactoryGirl.create(:post) }

    it "creates a new comment" do
      expect{
        post :create, post_id: existing_post.id, comment: FactoryGirl.attributes_for(:comment)
      }.to change(Comment, :count).by(1)

      expect(flash[:notice]).to_not be_nil
      expect(response).to redirect_to(blog_post_path(existing_post))
    end
    it "reloads the page if errors are present" do
      FactoryGirl.create(:comment, post: existing_post)

      post :create, post_id: existing_post, comment: {body: ""}

      expect(assigns(:comments).size).to eq(1)
      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template("posts/show")
    end
    it "shouldn't throw an exeption for invalid byte sequence errors" do
      body = "nike japan\r\n\xA5ʥ\xA4\xA5\xADֱ\x86ӵ\xEA"

      post :create, post_id: existing_post, comment: FactoryGirl.attributes_for(:comment, body: body)

      expect(response).to be_success
      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template("posts/show")
    end
  end

  describe "flag_spam" do
    it "should update a comment's spam flag" do
      login_as user
      comment = FactoryGirl.create(:comment, :spam_flag => false)

      xhr :post, :flag_spam, :post_id => comment.post.id, :comment_id => comment.id

      expect(assigns(:comment)).to eq(comment)
      expect(assigns(:comment)).to be_spam_flag
      expect(response).to be_success
    end
  end

  describe "edit" do
    it "has the requested comment" do
      login_as user
      comment = FactoryGirl.create(:comment)

      get :edit, post_id: comment.post_id, comment_id: comment.id

      expect(assigns(:comment)).to eq(comment)
    end
    it "requires a user be logged in" do
      comment = FactoryGirl.create(:comment)

      get :edit, post_id: comment.post_id, comment_id: comment.id

      expect(response).to redirect_to(root_path)
      expect(flash.alert).to_not be_nil
    end
  end

  describe "update" do
    it "updates the comment" do
      login_as user
      comment = FactoryGirl.create(:comment, body: "Old Body")

      patch :update, post_id: comment.post_id, comment_id: comment.id, comment: {body: "New Body"}

      expect(assigns(:comment).body).to eq("New Body")
      expect(response).to redirect_to blog_post_path(comment.post)
    end
  end

  describe "preview" do
    it "builds a comment to preview" do
      post :preview, comment: {body: "Body"}, format: "js"

      expect(assigns(:comment)).to_not be_nil
      expect(assigns(:comment)).to be_new_record
      expect(response).to be_success
    end
  end

  describe "destroy" do
    it "should remove the post" do
      login_as user
      post = FactoryGirl.create(:post)
      comment = FactoryGirl.create(:comment, post: post)

      xhr :delete, :destroy, post_id: post.id, comment_id: comment.id

      expect(response).to be_success
      expect(post.comments.size).to eq(0)
    end
  end

end
