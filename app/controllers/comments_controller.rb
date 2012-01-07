class CommentsController < ApplicationController

  before_filter :login_required, :only => [:edit, :update]
  before_filter :find_post
  
  active_tab :blog

  def edit
    @comment = @post.comments.find(params[:comment_id])
  end

  def update
    @comment = @post.comments.find(params[:comment_id])
    @comment.update_attributes!(params[:comment])
    redirect_to blog_post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
