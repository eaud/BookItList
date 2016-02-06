class SessionsController < ApplicationController

  def index
    redirect_to activities_path if logged_in?
  end

  def create
    binding.pry
    fb_auth_hash = request.env['omniauth.auth']
    if @user = User.find_by(uid: fb_auth_hash["uid"])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.find_or_create_from_oauth(fb_auth_hash)
      session[:user_id] = @user.id
      render 'sessions/first_login'
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to root_path
  end

end
