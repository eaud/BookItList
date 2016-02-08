class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    fb_auth_hash = request.env['omniauth.auth']
    if @user = User.find_by(uid: fb_auth_hash["uid"])
      sign_in(:user, @user)
      redirect_to root_path
    else
      @user = User.find_or_create_from_oauth(fb_auth_hash)
      sign_in(:user, @user)
      binding.pry
      flash[:notice] = "Welcome! You have signed up successfully. Please fill out as much of the info below as possible. Especially the tags because that is how we find awesome acitivities for you!!!"
      render "users/edit"
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
