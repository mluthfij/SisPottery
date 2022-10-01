class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @render_cart = false
    @orders = current_user.orderables.all
  end
  
  def add
    @product = Product.find_by(id: params[:id])
    @current_order = @cart.orderables.find_by(product_id: @product.id)
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
    # respond_to do |format|
    #     format.html { redirect_to request.referrer, notice: "Product was successfully added to cart." }
    #     format.json { render :show, status: :created, location: request.referrer }
    # end

    # # without refresh
    respond_to do |format|
      format.turbo_stream do
        if !@current_order.nil?
          # update
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_update',
                                          partial: 'products/cartupdate')
                              ]

        elsif @current_order.nil?
          # add
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_add',
                                          partial: 'products/cartupdate')
                              ]
        end
      end
        # render turbo_stream: turbo_stream.replace('cart',
        #                                   partial: 'cart/cart',
        #                                   locals: { cart: @cart })
    end
    # 
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy
    # # refresh
    # respond_to do |format|
    #     format.html { redirect_to request.referrer, notice: "Product was successfully deleted from cart." }
    #     format.json { render :show, status: :created, location: request.referrer }
    # end
    

    # without refresh
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter'),
                              turbo_stream.replace('cart_update',
                                          partial: 'products/cartadd')
                              ]
      end
    end
    # 
  end
end
