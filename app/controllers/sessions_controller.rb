class SessionsController < ApplicationController

  def create
    fb_auth_hash = request.env['omniauth.auth']
    @user = User.find_or_create_from_oauth(fb_auth_hash)
    session[:user_id] = @user.id
    # binding.pry
    redirect_to root_path
  end

  def delete
    session[:user_id] = nil
    redirect_to root_path
  end

end
