module Admin
  class CommentsController < ApplicationController
    before_action :correct_user, only: :destroy 
    before_action :authenticate_user!
    before_action :set_params, only: [:create, :destroy]

    def create
      @comment = current_user.comments.new(params_comment)
      if @comment.save
        flash[:notice] = "Comment has been sent successfully."
      else
        flash[:notice] = @comment.errors.full_messages.to_sentence
      end
        redirect_to product_path(@product)
    end
    def destroy
      @comment = @product.comments.find(params[:id])
      @comment.destroy
      redirect_to product_path(@product)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to request.referrer, notice: "Not authorized to destroy this comment." if @comment.nil?
    end

    private
    def set_params
      @product = Product.find(params[:product_id])
    end
    def params_comment
      params
      .require(:comment)
      .permit(:reply_to, :content, :parent_id)
      .merge(product_id: params[:product_id])
    end
    
  end
end
