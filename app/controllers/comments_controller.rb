class CommentsController < ApplicationController
  before_filter :require_user

  def new
  end

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.post_id = params[:post_id]
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:notice] = "New comment successfully created!"
      redirect_to post_path(params[:post_id])
    else
      flash[:alert] = "Comment can't be blank!"
      redirect_to new_post_comment_path(params[:post_id])
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    Vote.create(voteable: @comment, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { redirect_to post_path(params[:post_id]) }
      format.js
    end
  end
end