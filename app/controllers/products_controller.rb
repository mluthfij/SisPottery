class ProductsController < ApplicationController
  before_action :authenticate_user!, only: :upvote
  # GET /products or /products.json
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(cached_votes_score: :desc).page(params[:page])
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
    @keeps = @product.keeps.all
    # find current order in show page
    if user_signed_in?
      @showorder = @cart.orderables.find_by(product_id: @product.id)
    end
  end
end
