class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(email: params[:user][:email],
    name: params[:user][:name],
    bio: params[:user][:bio],
    image_url: params[:user][:image_url])
    redirect_to user_path
  end

  def destroy
    @user = current_user
  end
end
