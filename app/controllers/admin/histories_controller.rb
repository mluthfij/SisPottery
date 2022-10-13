module Admin
  class HistoriesController < ApplicationController
    
    def show
      # @orders = Orderable.all
      @orders = Orderable.all
      @quantity_vessel = Vessel.sum(:quantity)
      @price_vessel = Vessel.sum(:price)
    end

    def add
      @orderable = Orderable.find_by(id: params[:id])
      current_vessel = @history.vessels.find_by(orderable_id: @orderable.id)
      
      quantity = params[:quantity].to_i
      price = params[:price].to_i
      date = params[:date].to_s
      order_at = params[:order_at].to_s
      if current_vessel
        current_vessel.update(orderable: @orderable, user: current_user)
        redirect_to request.referrer, notice: "History was successfully updated."
      else
        @new_history = @history.vessels.new(date: date, quantity: quantity, price: price, order_at: order_at, orderable: @orderable, user: current_user)
        if @new_history.save 
          redirect_to request.referrer, notice: "History was successfully saved."
        else
          redirect_to request.referrer, notice: "History was failed to saved."
        end
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

  end
end
