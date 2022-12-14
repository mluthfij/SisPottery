module Admin
  class PagesController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    def dashboard
      @products = Product.all
      @chatboxes = Chatroom.all
      @customers = User.all
    end

    def customer
      # @customers = User.all
      @q = User.ransack(params[:q])
      @customers = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    end

    def adminlist
      @customers = User.all
    end

    def add_admin
      @customers = User.find(params[:id])
      if @customers.admin == true
        @customers.update_attribute(:admin, false)
      elsif @customers.admin == false
        @customers.update_attribute(:admin, true)
      end
      redirect_to request.referrer
    end
    
    def newadmin
      @customers = User.all
    end

    def order
      # @orders = Orderable.all
      @q = Orderable.ransack(params[:q])
      @orders = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    end

    def chatbox
      # @chatboxes = Chatroom.all
      @q = Chatroom.all.ransack(params[:q])
      @chatboxes = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
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
