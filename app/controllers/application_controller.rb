class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :current_cart, if: :user_signed_in?
  before_action :initialize_history, if: :user_signed_in?
  before_action :initialize_bucket, if: :user_signed_in?
  
  def initialize_bucket
    @bucket = Bucket.find_by(id: @bucket)
    if !@bucket && current_user
      @bucket = Bucket.find_by(user_id: current_user.id)
    end
    if @bucket && current_user && @bucket.user_id != current_user
      @bucket.update(user_id: current_user.id)
    end
    if @bucket.nil?
      @bucket = Bucket.create(user_id: current_user.id)
    else
      @bucket
    end
  end

  def initialize_history
    @history = History.find_by(id: @history)
    if !@history && current_user
      @history = History.find_by(user_id: current_user.id)
    end
    if @history && current_user && @history.user_id != current_user
      @history.update(user_id: current_user.id)
    end
    if @history.nil?
      # @history = current_user.historys.create
      @history = History.create(user_id: current_user.id)
    else
      @history
    end
    # @history = current_user.historys.create
  end

  def current_cart
    @cart = Cart.find_by(id: @cart)
    if !@cart && current_user
      @cart = Cart.find_by(user_id: current_user.id)
    end
    if @cart && current_user && @cart.user_id != current_user
      @cart.update(user_id: current_user.id)
    end
    if @cart.nil?
      # @cart = current_user.carts.create
      @cart = Cart.create(user_id: current_user.id)
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

  private
  def record_not_found
    redirect_to root_path
    flash[:notice] = "Record not found!"
  end

  protected
   def configure_permitted_parameters
      added_attrs = [:firstname, :lastname, :my_address, :phone, :wa_phone, :username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :my_address, :phone, :wa_phone, :avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
   end  
end
