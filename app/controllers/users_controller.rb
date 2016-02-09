class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    sign_in(:user, User.find(session[:id])) if !current_user
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render "edit"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session["warden.user.user.key"][0][0] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :image_url, :tag_ids => [])
  end
end
