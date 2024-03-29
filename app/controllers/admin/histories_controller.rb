module Admin
  class HistoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    def show
      # @orders = Orderable.all
      # @vessels = Vessel.all
      
      @q = Vessel.ransack(params[:q])
      @vessels = @q.result(distinct: true).order(created_at: :desc).page(params[:page])

      @quantity_vessel = Vessel.sum(:quantity)
      @price_vessel = Vessel.sum(:price)
    end

    def add
      description = params[:description].to_s
      quantity = params[:quantity].to_i
      price = params[:price].to_i
      date = params[:date].to_s
      order_at = params[:order_at].to_s
      customer = params[:customer].to_s
      product_price = params[:product_price].to_i
      product_name = params[:product_name].to_s
      product_id = params[:product_id].to_i 
      point = params[:point].to_i 
      user_id = params[:user_id].to_i 
      
      @new_history = @history.vessels.new(point: point, product_id: product_id, customer: customer, product_price: product_price, 
                                      product_name: product_name, quantity: quantity, price: price,
                                      order_at: order_at, date: date, user_id: user_id, description: description)
                                      # order_at: order_at, date: date, user: current_user)
      if @new_history.save
        delete_to_save
        # redirect_to request.referrer, notice: @new_history.errors.full_messages.to_sentence
      else
        redirect_to request.referrer, notice: @new_history.errors.full_messages.to_sentence
      end
      
    end

    def remove
      @vessel = Vessel.find_by(id: params[:id])
      if @vessel.destroy
        redirect_to request.referrer, notice: "History was successfully deleted."
      else
        redirect_to request.referrer, notice: "History was failed to delete."
      end
    end

    def delete_to_save
      @orderable = Orderable.find_by(id: params[:id])
      if @orderable.destroy
        redirect_to admin_history_url, notice: "Order was successfully processed."
      else
        redirect_to request.referrer, notice: "Order was failed to process."
      end
      
    end
    

    
    # def show
    #   @orders = Orderable.all
    #   @quantity_vessel = Vessel.sum(:quantity)
    #   @price_vessel = Vessel.sum(:price)
    # end

    # def add
    #   @orderable = Orderable.find_by(id: params[:id])
    #   current_vessel = @history.vessels.find_by(orderable_id: @orderable.id)
      
    #   quantity = params[:quantity].to_i
    #   price = params[:price].to_i
    #   date = params[:date].to_s
    #   order_at = params[:order_at].to_s
    #   if current_vessel
    #     current_vessel.update(orderable: @orderable, user: current_user)
    #     redirect_to request.referrer, notice: "History was successfully updated."
    #   else
    #     @new_history = @history.vessels.new(date: date, quantity: quantity, price: price, order_at: order_at, orderable: @orderable, user: current_user)
    #     if @new_history.save 
    #       redirect_to request.referrer, notice: "History was successfully saved."
    #     else
    #       redirect_to request.referrer, notice: "History was failed to saved."
    #     end
    #   end
    # end

    # def remove
    #   @vessel = Vessel.find_by(id: params[:id])
    #   if @vessel.destroy
    #     redirect_to request.referrer, notice: "History was successfully deleted."
    #   else
    #     redirect_to request.referrer, notice: "History was failed to delete."
    #   end
    # end
    
    
    protected
    # redirect if user not logged in or does not have a valid role
    def restrict_user_by_role
      redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
    end
  end
end
