  # class OrderablesController < ApplicationController
  #   # before_action :set_orderable, only: %i[ show edit update destroy ]
  #   before_action :authenticate_user!

  #   # PATCH/PUT /orderables/1 or /orderables/1.json
  #   def update
      
  #     # @profile = User.find(params[:id])
  #     @orderable = Orderable.find_by(id: params[:id])
  #     if @orderable.update(params.permit(images: []))
  #         redirect_to request.referrer, notice: "Avatar was successfully updated."
  #     else
  #         redirect_to request.referrer, notice: @orderable.errors.full_messages.to_sentence
  #     end

  #     # @product = Product.find_by(id: params[:id])
  #     # @orderable = @cart.orderables.find_by(product_id: @product)
  #     # respond_to do |format|
  #     #     if @orderable.update(orderable_params)
  #     #       format.html { redirect_to admin_orderable_url(@orderable), notice: "orderable was successfully updated." }
  #     #       format.json { render :show, status: :ok, location: @orderable }
  #     #     else
  #     #       format.html { render :edit, status: :unprocessable_entity }
  #     #       format.json { render json: @orderable.errors, status: :unprocessable_entity }
  #     #     end
  #     # end
  #   end

  #   # DELETE /orderables/1 or /orderables/1.json
  #   # def destroy
  #   #   # add_cart
  #   #   @orderable.destroy

  #   #   respond_to do |format|
  #   #     format.html { redirect_to admin_orderables_url, notice: "orderable was successfully destroyed." }
  #   #     format.json { head :no_content }
  #   #   end
  #   # end

  #   private

  #     # Use callbacks to share common setup or constraints between actions.
  #   #   def set_orderable
  #   #     @orderable = orderable.find(params[:id])
  #   #   end

  #     # Only allow a list of trusted parameters through.
  #     def orderable_params
  #       params.permit(images: [])
  #     end
  # end
