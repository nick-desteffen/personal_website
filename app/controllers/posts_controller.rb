class PostsController < ApplicationController

  before_filter :login_required, only: [:new, :create, :edit, :update, :admin_index, :destroy]
  before_filter :find_post, only: [:show, :edit, :update]

  active_tab :blog

  def index
    page = params[:page] || 1
    @posts = Post.published.page(page)
  end

  def admin_index
    @posts = Post.order(:created_at).load
  end

  def show
    @comments = @post.comments.not_spam
    @comment = Comment.new
    @page_title = @post.title
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to blog_post_path(@post), notice: "New blog post created!"
    else
      flash.now.alert = "There was an error creating the new blog post."
      render action: :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to blog_post_path(@post), notice: "Updated blog post"
    else
      flash.now.alert = "There was an error updating the blog post."
      render action: :edit
    end
  end

private

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at, {tags: []}, related_links_attributes: [:url, :title, :_destroy, :id])
  end

end
