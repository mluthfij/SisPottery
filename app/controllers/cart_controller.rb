class CartController < ApplicationController
  before_action :check, except: :show, if: :user_signed_in?
  before_action :authenticate_user!

  def show
    @render_cart = false
    @orders = current_user.orderables.all
  end

  def addcart
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
      @cart.orderables.create(product: @product, description: description, quantity: quantity, user: current_user)
    end

    if !@current_order.nil?
      flash.now[:notice] = "Product has successfully updated"
    elsif @current_order.nil?
      flash.now[:notice] = "Product has successfully added to cart"
    end

    # # without refresh
    respond_to do |format|
      format.turbo_stream do
        # show_cart
        if !@current_order.nil?
          # update
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('show_notes',
                                          partial: 'cart/notes',
                                          locals: { cart: @cart }),
                              turbo_stream.update('show_cart',
                                          partial: 'cart/showcart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('payment_counter',
                                          partial: 'cart/payment_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('q_counter',
                                          partial: 'cart/q_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.prepend("turbo_flash", partial: "layouts/turboalert")
                              ]

        elsif @current_order.nil?
          # add
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('payment_counter',
                                          partial: 'cart/payment_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('q_counter',
                                          partial: 'cart/q_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.prepend("turbo_flash", partial: "layouts/turboalert")
                              ]
        end
      end
    end
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

    if !@current_order.nil?
      flash.now[:notice] = "Product has successfully updated"
    elsif @current_order.nil?
      flash.now[:notice] = "Product has successfully added to cart"
    end

    # # refresh
    respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Product was successfully added to cart." }
        format.json { render :show, status: :created, location: request.referrer }
    end

    # # # without refresh
    # respond_to do |format|
    #   format.turbo_stream do
    #     if !@current_order.nil?
    #       # update
    #     render turbo_stream: [turbo_stream.replace('cart',
    #                                       partial: 'cart/cart',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('cart_counter',
    #                                       partial: 'layouts/cart_counter',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('cart_update',
    #                                       partial: 'products/cartupdate'),
    #                           turbo_stream.replace('show_cart',
    #                                       partial: 'cart/showcart',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.prepend("turbo_flash", partial: "layouts/turboalert")
    #                           ]

    #     elsif @current_order.nil?
    #       # add
    #     render turbo_stream: [turbo_stream.replace('cart',
    #                                       partial: 'cart/cart',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('cart_counter',
    #                                       partial: 'layouts/cart_counter',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('cart_add',
    #                                       partial: 'products/cartupdate'),
    #                           turbo_stream.prepend("turbo_flash", partial: "layouts/turboalert")
    #                           ]
    #     end
    #   end
    # end
    #   # end of cart no refresh

        # render turbo_stream: turbo_stream.replace('cart',
        #                                   partial: 'cart/cart',
        #                                   locals: { cart: @cart })
    # 
  end

  def removecart
    # Orderable.find_by(id: params[:id]).destroy
    @orderable = Orderable.find_by(id: params[:id])
    @orderable.destroy
    flash.now[:notice] = "Product has successfully deleted from cart"
    # without refresh
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                          partial: 'cart/cart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('cart_counter',
                                          partial: 'layouts/cart_counter'),
                              turbo_stream.update('show_cart',
                                          partial: 'cart/showcart',
                                          locals: { cart: @cart }),
                              turbo_stream.update('payment_counter',
                                          partial: 'cart/payment_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update('q_counter',
                                          partial: 'cart/q_counter',
                                          locals: { cart: @cart }),
                              turbo_stream.update("turbo_flash", partial: "layouts/turboalert")
                              ]
      end
    end
    # 
  end

  def remove
    # Orderable.find_by(id: params[:id]).destroy
    @orderable = Orderable.find_by(id: params[:id])
    @orderable.destroy
    flash.now[:notice] = "Product has successfully deleted from cart"
    # without refresh
    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream: [turbo_stream.replace('cart',
    #                                       partial: 'cart/cart',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('cart_counter',
    #                                       partial: 'layouts/cart_counter'),
    #                           turbo_stream.replace('cart_update',
    #                                       partial: 'products/cartadd'),
    #                           turbo_stream.update('show_cart',
    #                                       partial: 'cart/showcart',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('payment_counter',
    #                                       partial: 'cart/payment_counter',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update('q_counter',
    #                                       partial: 'cart/q_counter',
    #                                       locals: { cart: @cart }),
    #                           turbo_stream.update("turbo_flash", partial: "layouts/turboalert")
    #                           ]
    #   end
    # end
    # 
    
    # with refresh
    respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Product was successfully deleted from cart." }
        format.json { render :show, status: :created, location: request.referrer }
    end
  end

  def delete
    @post = Product.find_by_id(params[:id])
    @orderable = Orderable.find_by(id: params[:id])
    @orderable.destroy
    # with refresh
    respond_to do |format|
        format.html { redirect_to product_path(@post), notice: "Product was successfully deleted from cart." }
        format.json { render :show, status: :created, location: product_path(@post) }
    end
  end

  private 
  def check
    unless current_user.firstname? && current_user.my_address? && current_user.phone || current_user.wa_phone
        redirect_to edit_user_registration_path(current_user.id), notice: "You must complete your profile data before order!"
    end
  end
end
