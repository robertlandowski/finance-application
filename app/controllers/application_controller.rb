class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:timezone, :email, :password, :password_confirmation) }
  end

  protect_from_forgery with: :exception
  private
   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"
       redirect_to new_session_path
     end
   end
end
