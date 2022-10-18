module Admin
  class BucketController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role
    
    def show
      @keeps = Keep.all
      @quantity_keep = Keep.sum(:quantity)
      @price_keep = Keep.sum(:total_price)
    end

    def add
      # @keep = Keep.find_by(point: params[:point])
      customer = params[:customer].to_s
      product_price = params[:product_price].to_i
      product_name = params[:product_name].to_s
      quantity = params[:quantity].to_i
      total_price = params[:total_price].to_i
      order_start = params[:order_start].to_s
      order_end = params[:order_end].to_s
      point = params[:point].to_i 
      user_id = params[:user_id].to_i 

      point_orderable = params[:point_orderable].to_i 

      # if @keep
      #   @keep.update(point: point, customer: customer, product_price: product_price, product_name: product_name, 
      #                                   quantity: quantity, total_price: total_price, order_start: order_start, 
      #                                   order_end: order_end, user: current_user)
      #     redirect_to request.referrer, notice: "bucket was successfully updated."

      # else
      # 
      @new_bucket = @bucket.keeps.new(point: point, customer: customer, product_price: product_price, 
                                      product_name: product_name, quantity: quantity, total_price: total_price, 
                                      order_start: order_start, order_end: order_end, user_id: user_id)
                                      # order_start: order_start, order_end: order_end, user: current_user)
      if @new_bucket.save
        remove
      else
        redirect_to request.referrer, notice: @new_bucket.errors.full_messages.to_sentence
      end
      # end
    end
    
    

    def remove
      @vessel = Vessel.find_by(id: params[:id])
      if @vessel.destroy
        redirect_to request.referrer, notice: "Order was successfully saved."
      else
        redirect_to request.referrer, notice: "Order was failed to save."
      end
    end

    
    
    protected
    # redirect if user not logged in or does not have a valid role
    def restrict_user_by_role
      redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
    end
  end
end
