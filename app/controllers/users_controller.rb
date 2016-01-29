class UsersController < ApplicationController
  def show
    binding.pry
    @user = User.find(params[:id])
  end

  def edit
    binding.pry
    @user = current_user
  end

  def update
    binding.pry
    @user = current_user
  end

  def destroy
    @user = current_user
  end
end
