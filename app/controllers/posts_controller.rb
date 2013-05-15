class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = 1
    if @post.save
      flash[:notice] = "New Post Successfully Created!"
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:alert] = "This Post Does NOT Exist!"
      redirect_to posts_path
    end
  end
end
