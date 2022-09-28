class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    # find current order in show page
    if user_signed_in?
      @showorder = @cart.orderables.find_by(product_id: @product.id)
    end
  end
end
