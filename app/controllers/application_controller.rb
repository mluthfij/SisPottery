class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
    
  
  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_pages_dashboard_path
    elsif !current_user.admin?
      products_path
    end
  end

  protected
    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
    #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password)}
    # end
    
   def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
   end  
end
