class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    binding.pry
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  def destroy
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :image_url, :tag_ids => [])
  end
end
