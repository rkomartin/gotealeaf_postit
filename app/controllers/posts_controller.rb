class PostsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = session[:user_id]

    if @post.save
      flash[:notice] = "New post successfully created!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

    if @post.user_id != session[:user_id]
      flash[:error] = "Posts can be edited only by owner"
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.user_id != session[:user_id]
      flash[:error] = "Posts can be edited only by owner"
      redirect_to posts_path
    end
    
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was successfully updated!"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:alert] = "This post does NOT exist!"
      redirect_to posts_path
    end
  end
end
