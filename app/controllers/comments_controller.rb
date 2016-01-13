class CommentsController < ApplicationController

  before_filter :login_required, except: [:create, :preview]
  before_filter :find_post, only: [:create, :edit, :update, :destroy]

  active_tab :blog

  def create
    begin
      @comments = @post.comments.not_spam.load
      @comment = @post.comments.build(comment_params)
      @comment.http_request = request
      if @comment.save
        redirect_to blog_post_path(@post), notice: "Thanks for commenting!"
      else
        flash.now.alert = "There was an error with your comment. Please verify all the fields are correct."
        render template: "posts/show"
      end
    rescue ArgumentError => exception
      @comment = @post.comments.build
      flash.now.alert = "Sorry, but you appear to be posting some spam."
      render template: "posts/show"
    end
  end

  def edit
    @comment = @post.comments.find(params[:comment_id])
  end

  def update
    @comment = @post.comments.find(params[:comment_id])
    @comment.update_attributes(comment_params)
    redirect_to blog_post_path(@post)
  end

  def flag_spam
    @comment = Comment.find(params[:comment_id])
    @comment.flag_spam!
  end

  def preview
    @comment = Comment.preview(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
  end

  private

  def find_post
    @post = Post.where(slug: params[:post_id]).first
  end

  def comment_params
    params.require(:comment).permit(:email, :name, :body, :url, :post_id, :new_comment_notification)
  end

end
