class RegistrationsController < Devise::RegistrationsController
 before_filter :configure_permitted_parameters, :only => [:create]

 def create
   super
 end

 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
 end

 def account_update_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

end
