require 'rails_helper'

describe PostsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:published_post) { FactoryGirl.create(:post, published_at: 1.week.ago) }
  let(:unpublished_post) { FactoryGirl.create(:post, published_at: nil) }

  describe "index" do
    it "has only published posts" do
      published_post
      unpublished_post

      get :index

      expect(assigns(:posts).size).to eq(1)
      expect(assigns(:posts)).to include(published_post)
      expect(assigns(:posts)).to_not include(unpublished_post)
    end
    it "paginates 5 per page" do
      6.times { |i| FactoryGirl.create(:post, published_at: i.weeks.ago) }

      get :index, page: 2

      expect(assigns(:posts).size).to eq(1)
    end
  end

  describe "show" do
    it "has the requested post, a new comment, the comments for the post, and the overridden page title" do
      comment = FactoryGirl.create(:comment, post: published_post)

      get :show, post_id: published_post

      expect(assigns(:post)).to eq(published_post)
      expect(assigns(:comments).size).to eq(1)
      expect(assigns(:comment)).to_not be_nil
      expect(assigns(:page_title)).to eq(assigns(:post).title)
    end
  end

  describe "new" do
    it "has a post object" do
      login_as user

      get :new

      expect(assigns(:post)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "create" do
    it "creates a new post" do
      login_as user

       expect{
         post :create, post: {title: "The Title", body: "The Body", tags: ["a", "b", "c"], related_links_attributes: {"0" => {url: "http://www.google.com", title: "Google"}}}
       }.to change(Post, :count).by(1)

      expect(assigns(:post).related_links.count).to eq(1)
      expect(assigns(:post).tags.size).to eq(3)
      expect(flash.notice).to_not be_nil
      expect(response).to redirect_to blog_post_path(assigns(:post))
    end
    it "reloads the page if errors are present" do
      login_as user

      expect{
        post :create, post: {body: ""}
      }.to_not change(Post, :count)

      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template(:new)
    end
  end

  describe "edit" do
    it "has the post to edit" do
      login_as user

      get :edit, post_id: published_post

      expect(assigns(:post)).to eq(published_post)
    end
  end

  describe "update" do
    it "updates the post" do
      login_as user

      put :update, post_id: published_post, post: {body: "Updated body"}

      expect(flash[:notice]).to_not be_nil
      expect(response).to redirect_to blog_post_path(published_post)
    end
    it "reloads the page if errors are present" do
      login_as user

      put :update, post_id: published_post, post: {body: ""}

      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template(:edit)
    end
  end

  describe "admin_index" do
    it "has a listing of all blog posts" do
      login_as user
      published_post
      unpublished_post

      get :admin_index

      expect(assigns(:posts).size).to eq(2)
      expect(assigns(:posts)).to include(unpublished_post)
    end
  end

end
