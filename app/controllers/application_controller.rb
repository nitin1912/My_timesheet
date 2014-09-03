class ApplicationController < ActionController::Base
  protect_from_forgery
   
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You don't have permission to access this page"
    redirect_to root_path
  end
  def authorize
    unless current_user.email == "admin@admin.com"
      flash[:alert]= "You don't have permission to access this page"
     redirect_to root_path
    end
  end
end
 
