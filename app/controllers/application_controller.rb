class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :authenticate_user!
  protect_from_forgery with: :exception
  private
   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"
       redirect_to new_session_path
     end
   end
end
