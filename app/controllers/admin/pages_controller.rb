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
    def order
      @orders = Orderable.all
    end
    def chatbox
      @chatboxes = Chatroom.all
    end
    def chatroom
      @chatroom = Chatroom.find_by_id(params[:chatroom_id])
      @message = Message.new
      if user_signed_in?
        # @messages = Message.custom_display
        @messages = @chatroom.messages.custom_display
      end
    end
    
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
