module Admin
  class PagesController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    def dashboard
      @products = Product.all
    end
    def customer
      @customers = User.all
    end
    def adminlist
      @useradmin = User.all
    end
    def newadmin
      @alluser = User.all
    end
    def message
    end
    def order
      # @carts = Cart.find_by(id: @cart)
      # @orders = @carts.orderables.all
      @orders = Orderable.all
      # @product = Product.find_by_id(:product_id)
      # @total_cart = Cart.find_by(id: @cart)
    end
    # def home
    # end
    def about
    end
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
