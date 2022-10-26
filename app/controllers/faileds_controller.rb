class FailedsController < ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.faileds.ransack(params[:q])
    @faileds = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    @quantity_failed = current_user.faileds.sum(:quantity)

  end
end
