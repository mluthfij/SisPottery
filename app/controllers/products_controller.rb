class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    # @products = Product.all
    @products = Product.all.order(cached_votes_score: :desc)
  end

  def upvote
  @product = Product.find(params[:id])
    if current_user.voted_up_on? @product
      @product.unvote_by current_user
    else
      @product.upvote_by current_user
    end
  render "vote.js.erb"
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
