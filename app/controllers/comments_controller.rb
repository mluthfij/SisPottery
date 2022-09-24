class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(set_params)
    redirect_to product_path(@product)
  end
  def destroy
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    redirect_to product_path(@product)
  end

  private
  def set_params
    params
    .require(:comment)
    .permit(:reply_to, :content, :parent_id)
    .merge(product_id: params[:product_id])
    # params[:comment]
    # .permit(:name, :reply_to, :content)
  end
  
end
