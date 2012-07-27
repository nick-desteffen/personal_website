require 'spec_helper'

describe PostsController do

  let(:user) { FactoryGirl.create(:user) }
    
  describe "index" do
    it "has only published posts" do
      published_post = FactoryGirl.create(:post, :published_at => 1.week.ago)
      unpublished_post = FactoryGirl.create(:post, :published_at => nil)
      
      get :index
      
      assigns(:posts).size.should == 1
      assigns(:posts).include?(published_post).should == true
      assigns(:posts).include?(unpublished_post).should_not == true
    end
    it "paginates 5 per page" do
      6.times { |i| FactoryGirl.create(:post, published_at: i.weeks.ago) }

      get :index, page: 2

      assigns(:posts).size.should == 1
    end
  end
  
  describe "show" do
    it "has the requested post, a new comment, the comments for the post, and the overridden page title" do
      post = FactoryGirl.create(:post)
      comment = FactoryGirl.create(:comment, :post => post)
      
      get :show, :post_id => post
      
      assigns(:post).should == post
      assigns(:comments).size.should == 1
      assigns(:comment).should_not be_nil
      assigns(:page_title).should == assigns(:post).title
    end
  end
  
  describe "new" do
    it "has a post object" do
      login_as user
      
      get :new
      
      assigns(:post).should_not be_nil
      response.should be_success
    end
  end
  
  describe "create" do
    it "creates a new post" do
      login_as user

       expect{
         post :create, :post => FactoryGirl.attributes_for(:post)
       }.to change(Post, :count).by(1)
      
      flash.notice.should_not be_nil
      response.should redirect_to blog_post_path(assigns(:post))
    end
    it "reloads the page if errors are present" do
      login_as FactoryGirl.create(:user)
      
      Post.any_instance.stubs(:save).returns(false)
      
      expect{
        post :create, :post => {}
      }.to_not change(Post, :count)
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:new)
    end
  end
  
  describe "edit" do
    it "has the post to edit" do
      login_as user
      post = FactoryGirl.create(:post)
      
      get :edit, :post_id => post
      
      assigns(:post).should == post
    end
  end
  
  describe "update" do
    it "updates the post" do
      login_as user
      post = FactoryGirl.create(:post)
      
      Post.any_instance.stubs(:update_attributes).returns(true)
      
      put :update, :post_id => post, :post => {}
      
      flash[:notice].should_not be_nil
      response.should redirect_to blog_post_path(post)
    end
    it "reloads the page if errors are present" do
      login_as user
      post = FactoryGirl.create(:post)
      
      Post.any_instance.stubs(:update_attributes).returns(false)
      
      put :update, :post_id => post, :post => {}
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:edit)
    end
  end
  
  describe "admin_index" do
    it "has a listing of all blog posts" do
      login_as user
      published_post = FactoryGirl.create(:post)
      unpublished_post = FactoryGirl.create(:post, :published_at => nil)
      
      get :admin_index
      
      assigns(:posts).size.should == 2
      assigns(:posts).include?(unpublished_post).should == true
    end
  end
      
end
