class CommentsController < ApplicationController
  before_filter :require_user, only: [:new, :create]

  def index
    @post = Post.find_by_id(params[:post_id])
    @comments = @post.comments
  end

  def new
  end

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.post_id = params[:post_id]
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:notice] = "New comment successfully created!"
      redirect_to post_comments_path
    else
      flash[:alert] = "Comment can't be blank!"
      redirect_to new_post_comment_path(params[:post_id])
    end
  end
end