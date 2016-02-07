class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # helper_method :current_user, :user_signed_in?
  before_action :authenticate_user!, :only => [:destroy]

private

# def current_user
#   @current_user ||= User.find(session["warden.user.user.key"][0][0]) if session["warden.user.user.key"][0][0]
#   if @current_user && @current_user.token_expiration < Time.now
#     session["warden.user.user.key"][0][0] = nil
#     @current_user = nil
#   end
#   @current_user
# end
#
# def user_signed_in?
#   !!current_user
# end



end
