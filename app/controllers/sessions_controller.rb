class SessionsController < ApplicationController

  def index
    redirect_to activities_path if logged_in?
  end

  def create
    # binding.pry
    fb_auth_hash = request.env['omniauth.auth']
    @user = User.find_or_create_from_oauth(fb_auth_hash)
    session[:user_id] = @user.id
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js{}
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to root_path
  end

end
