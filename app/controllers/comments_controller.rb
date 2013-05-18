class CommentsController < ApplicationController
  def index
    @comments = Post.find_by_id(params[:post_id]).comments
  end

  def new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.post_id = params[:post_id]
    @comment.user_id = 1 #TODO Use user_id from authentication
    if @comment.save
      flash[:notice] = "New comment successfully created!"
      redirect_to post_comments_path
    else
      flash[:alert] = "Comment can't be blank!"
      redirect_to new_post_comment_path(params[:post_id])
    end
  end
end