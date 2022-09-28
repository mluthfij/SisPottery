class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :current_cart, if: :user_signed_in?

  def current_cart
    @cart = Cart.find_by(id: @cart)
    if !@cart && current_user
      @cart = Cart.find_by(user_id: current_user.id)
    end
    if @cart && current_user && @cart.user_id != current_user
      @cart.update(user_id: current_user.id)
    end
    if @cart.nil?
      @cart = current_user.carts.create
    else
      @cart
    end
    # @cart = current_user.carts.create
  end

  def set_render_cart
      @render_cart = true
  end
  
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
   def configure_permitted_parameters
      added_attrs = [:firstname, :lastname, :my_address, :phone, :wa_phone, :username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :my_address, :phone, :wa_phone, :avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
   end  
end
