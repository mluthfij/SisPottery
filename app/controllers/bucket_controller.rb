class BucketController < ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.keeps.ransack(params[:q])
    @keeps = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    @quantity_keep = current_user.keeps.sum(:quantity)
    @price_keep = current_user.keeps.sum(:total_price)
  end
end
