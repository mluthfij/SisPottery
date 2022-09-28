class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @render_cart = false
    @orders = current_user.orderables.all
  end
  
  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    description = params[:description].to_s

    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity, description: description)
    elsif quantity <= 0
      current_orderable.destroy
    else
      # @cart.orderables.create!(product: @product, description: description, quantity: quantity, user: current_user)
      @cart.orderables.create(product: @product, description: description, quantity: quantity, user: current_user)
    end
    
    # # refresh
    respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Product was successfully added to cart." }
        format.json { render :show, status: :created, location: request.referrer }
    end

    # # without refresh
    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream: turbo_stream.replace('cart',
    #                                       partial: 'cart/cart',
    #                                       locals: { cart: @cart })
    #   end
    # end
    # 
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy
    # # refresh
    respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Product was successfully deleted from cart." }
        format.json { render :show, status: :created, location: request.referrer }
    end
    

    # # without refresh
    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream: turbo_stream.replace('cart',
    #                                       partial: 'cart/cart',
    #                                       locals: { cart: @cart })
    #   end
    # end
    # 
  end
end
