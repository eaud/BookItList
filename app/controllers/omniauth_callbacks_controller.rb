class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    fb_auth_hash = request.env['omniauth.auth']
    if @user = User.find_by(uid: fb_auth_hash["uid"])
      sign_in(:user, @user)
      redirect_to root_path
    else
      @user = User.find_or_create_from_oauth(fb_auth_hash)
      sign_in(:user, @user)
      render 'sessions/first_login'
    end
  end

  def failure
    redirect_to root_path
  end

private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
