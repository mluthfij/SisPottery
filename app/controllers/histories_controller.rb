class HistoriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :restrict_user_by_role

  def show
    # @vessels = Vessel.all
    # @vessels = current_user.vessels.all
    @q = current_user.vessels.ransack(params[:q])
    @vessels = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    @quantity_vessel = current_user.vessels.sum(:quantity)
    @price_vessel = current_user.vessels.sum(:price)
  end

  # def add
  #   quantity = params[:quantity].to_i
  #   price = params[:price].to_i
  #   date = params[:date].to_s
  #   order_at = params[:order_at].to_s

  #   customer = params[:customer].to_s
  #   product_price = params[:product_price].to_i
  #   product_name = params[:product_name].to_s
  #   point = params[:point].to_i 

  #   @new_history = @history.vessels.new(point: point, customer: customer, product_price: product_price, 
  #                                   product_name: product_name, quantity: quantity, price: price,
  #                                   order_at: order_at, date: date, user: current_user)
  #   if @new_history.save
  #     delete_to_save
  #     # redirect_to request.referrer, notice: @new_history.errors.full_messages.to_sentence
  #   else
  #     redirect_to request.referrer, notice: @new_history.errors.full_messages.to_sentence
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

  # def delete_to_save
  #   @orderable = Orderable.find_by(id: params[:id])
  #   if @orderable.destroy
  #     redirect_to request.referrer, notice: "Order was successfully processed."
  #   else
  #     redirect_to request.referrer, notice: "Order was failed to process."
  #   end
  # end
  
  
  # protected
  # # redirect if user not logged in or does not have a valid role
  # def restrict_user_by_role
  #   redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
  # end
end
