class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    unless current_user.email == "admin@admin.com"
      redirect_to root_path
    end
  end
end
 
