class FailedsController < ApplicationController
  before_action :authenticate_user!

  def show
    # @q = Failed.ransack(params[:q])
    @q = current_user.faileds.ransack(params[:q])
    @faileds = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
end
