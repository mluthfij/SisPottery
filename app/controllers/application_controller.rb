class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :initialize_cart

  # 
  def set_render_cart
      @render_cart = true
  end

  def initialize_cart
      @cart ||= Cart.find_by(id: session[:cart_id])

      if @cart.nil?
          @cart = Cart.create
          session[:cart_id] = @cart.id
      end
  end
  # 
  
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
      added_attrs = [:firstname, :lastname, :my_address, :phone, :wa_phone, :username, :email, :password, :password_confirmation, :remember_me]
      # added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :my_address, :phone, :wa_phone, :avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
   end  
end
