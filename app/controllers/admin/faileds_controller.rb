module Admin
  class FailedsController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    def show
    #   @faileds = Failed.all
      @q = Failed.ransack(params[:q])
      @faileds = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    end
    
    def add_cart
      quantity = params[:quantity].to_i
      total_price = params[:total_price].to_i
      # order_end = params[:order_end].to_s
      order_start = params[:order_start].to_s
      customer = params[:customer].to_s
      product_price = params[:product_price].to_i
      product_name = params[:product_name].to_s
      product_id = params[:product_id].to_i 

      user_id = params[:user_id].to_i

      @failed = Failed.new(product_id: product_id, customer: customer, product_price: product_price, 
                           product_name: product_name, quantity: quantity, total_price: total_price,
                           order_start: order_start, user_id: user_id)
      if @failed.save
        removecart
      else
        redirect_to request.referrer, notice: @failed.errors.full_messages.to_sentence
      end
    end
    

    def add_bucket
      quantity = params[:quantity].to_i
      total_price = params[:total_price].to_i
      order_start = params[:order_start].to_s
      customer = params[:customer].to_s
      product_price = params[:product_price].to_i
      product_name = params[:product_name].to_s
      product_id = params[:product_id].to_i 
      point = params[:point].to_i 

      user_id = params[:user_id].to_i

      @failed = Failed.new(product_id: product_id, customer: customer, product_price: product_price, 
                           product_name: product_name, quantity: quantity, total_price: total_price,
                           order_start: order_start, user_id: user_id)
      if @failed.save
          removebucket
      else
        redirect_to request.referrer, notice: @failed.errors.full_messages.to_sentence
      end
    end

    def removecart
        @orderable = Orderable.find_by(id: params[:id])
        if @orderable.destroy
            redirect_to admin_failed_url, notice: "Order was successfully saved."
        else
            redirect_to request.referrer, notice: "Order was failed to save."
        end
    end

    def removebucket
      @vessel = Vessel.find_by(id: params[:id])
      if @vessel.destroy
        redirect_to admin_failed_url, notice: "History was successfully deleted."
      else
        redirect_to request.referrer, notice: "History was failed to delete."
      end
    end

    
    
    protected
    # redirect if user not logged in or does not have a valid role
    def restrict_user_by_role
      redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
    end
  end
end
