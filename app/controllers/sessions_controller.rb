class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(name: params[:name]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you are logged in!"
      redirect_to root_path
    else
      flash[:error] = "Something wrong with the username or password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are logged out"
    redirect_to root_path
  end
end