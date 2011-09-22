require 'spec_helper'

describe PostsController do
  render_views
    
  describe "index" do
    it "has only published posts" do
      published_post = FactoryGirl.create(:post, :published_at => 1.week.ago)
      unpublished_post = FactoryGirl.create(:post, :published_at => nil)
      
      get :index
      
      assigns(:posts).size.should == 1
      assigns(:posts).include?(published_post).should == true
      assigns(:posts).include?(unpublished_post).should_not == true
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
      login_as FactoryGirl.create(:user)
      
      get :new
      
      assigns(:post).should_not be_nil
      response.should be_success
    end
  end
  
  describe "create" do
    it "creates a new post" do
      login_as FactoryGirl.create(:user)
      
      post :create, :post => FactoryGirl.create(:post).attributes
      
      flash.notice.should_not be_nil
      response.should redirect_to blog_post_path(assigns(:post))
    end
    it "reloads the page if errors are present" do
      login_as FactoryGirl.create(:user)
      
      Post.any_instance.stubs(:save).returns(false)
      
      post :create, :post => {}
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:new)
    end
  end
  
  describe "edit" do
    it "has the post to edit" do
      login_as FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      
      get :edit, :post_id => post
      
      assigns(:post).should == post
    end
  end
  
  describe "update" do
    it "updates the post" do
      login_as FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      
      Post.any_instance.stubs(:update_attributes).returns(true)
      
      put :update, :post_id => post, :post => {}
      
      flash[:notice].should_not be_nil
      response.should redirect_to blog_post_path(post)
    end
    it "reloads the page if errors are present" do
      login_as FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      
      Post.any_instance.stubs(:update_attributes).returns(false)
      
      put :update, :post_id => post, :post => {}
      
      flash.now[:alert].should_not be_nil
      response.should render_template(:edit)
    end
  end
  
  describe "create_comment" do
    it "creates a new comment" do
      existing_post = FactoryGirl.create(:post)
      existing_comment = FactoryGirl.create(:comment, :post => existing_post)
      Comment.any_instance.stubs(:save).returns(true)
      
      post :create_comment, :post_id => existing_post.id, :comment => {}
      
      flash[:notice].should_not be_nil
      response.should redirect_to(blog_post_path(existing_post))
    end
    it "reloads the page if errors are present" do
      existing_post = FactoryGirl.create(:post)
      existing_comment = FactoryGirl.create(:comment, :post => existing_post)
      Comment.any_instance.stubs(:save).returns(false)
      
      post :create_comment, :post_id => existing_post, :comment => {}
      
      assigns(:comments).size.should == 1
      flash.now[:alert].should_not be_nil
      response.should render_template(:show)
    end
  end
  
  describe "admin_index" do
    it "has a listing of all blog posts" do
      published_post = FactoryGirl.create(:post)
      unpublished_post = FactoryGirl.create(:post, :published_at => nil)
      user = FactoryGirl.create(:user)
      login_as user
      
      get :admin_index
      
      assigns(:posts).size.should == 2
      assigns(:posts).include?(unpublished_post).should == true
    end
  end
    
end
