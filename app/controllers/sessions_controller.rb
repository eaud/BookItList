class SessionsController < ApplicationController

  def index
    if user_signed_in?
      redirect_to activities_path
    else
      render "../views/sessions/index"
    end
  end

  def create
    fb_auth_hash = request.env['omniauth.auth']
    if @user = User.find_by(uid: fb_auth_hash["uid"])
      session["warden.user.user.key"][0][0] = @user.id
      redirect_to root_path
    else
      @user = User.find_or_create_from_oauth(fb_auth_hash)
      session["warden.user.user.key"][0][0] = @user.id
      render 'sessions/first_login'
    end
  end

  def delete
    sign_out @user
    redirect_to root_path
  end

end
