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
      @customers = User.all
    end
    def newadmin
      @customers = User.all
    end
    def message
      @allmsg = Message.all
    end
    def order
      @orders = Orderable.all
    end

    def chatuser
      @msg_container = MsgContainer.find_by_id(params[:msg_id])
      @messages = @msg_container.messages.all
    end
    
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
