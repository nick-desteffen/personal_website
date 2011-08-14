class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if @comment.save
      redirect_to blog_post_path(@post), :notice => "Thanks for commenting!"
    else
      flash.now[:alert] = "Please verify all the fields are correct."
      render :template => "posts/show"
    end
  end
  
end
