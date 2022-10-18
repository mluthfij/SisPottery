module Admin
  class CommentsController < ApplicationController
    before_action :correct_user, only: :destroy 
    before_action :authenticate_user!
    before_action :set_params, only: [:create, :destroy]
    before_action :restrict_user_by_role

    def create
      @comment = current_user.comments.new(params_comment)
      if @comment.save
        flash[:notice] = "Comment has been sent successfully."
      else
        flash[:notice] = @comment.errors.full_messages.to_sentence
      end
        redirect_to product_path(@product)
    end

    def like
      @product = Product.find(params[:product_id])
      @comment = @product.comments.find(params[:id])
      if current_user.voted_up_on? @comment
        @comment.unvote_by current_user
      else
        @comment.upvote_by current_user
      end
      render "like.js.erb"
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
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
