class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:post_id])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to blog_post_path(@post), :notice => "New blog post created!"
    else
      flash.now[:alert] = "There was an error creating the new blog post."
      render :action => :new
    end
  end

  def edit
    @post = Post.find(params[:post_id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    if @post.update_attributes(params[:post])
      redirect_to blog_post_path(@post), :notice => "Updated blog post"
    else
      flash.now[:alert] = "There was an error updating the blog post."
      render :action => :edit
    end
  end

end
