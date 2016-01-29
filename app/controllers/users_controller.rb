class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
  end

  def destroy
    @user = current_user
  end
end
