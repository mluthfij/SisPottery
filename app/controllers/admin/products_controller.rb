module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy stock preorder ]
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    # GET /products or /products.json
    def index
      # @products = Product.all
      # @products = Product.order(cached_votes_score: :desc).page(params[:page])
      # 
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true).order(cached_votes_score: :desc).page(params[:page])
    end

    def search
      index
      render :index
    end

    # GET /products/1 or /products/1.json
    def show
      # @keeps = Keep.all
      @keeps = @product.keeps.all
    end

    # GET /products/new
    def new
      @product = current_user.products.build
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products or /products.json
    def create
      @product = current_user.products.build(product_params)

      respond_to do |format|
        # 
        # if @product.images.count > 10
        #     format.html { render :new, status: :unprocessable_entity }
        #     format.json { render json: @product.errors, status: :unprocessable_entity }
        # else
        # 
          if @product.save
            format.html { redirect_to admin_product_url(@product), notice: "Product was successfully created." }
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        # 
        # end
        # 
      end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
      respond_to do |format|
        # 
        # if @product.images.count > 10
        #     format.html { render :new, status: :unprocessable_entity }
        #     format.json { render json: @product.errors, status: :unprocessable_entity }
        # else
        # 
          if @product.update(product_params)
            format.html { redirect_to admin_product_url(@product), notice: "Product was successfully updated." }
            format.json { render :show, status: :ok, location: @product }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        # 
        # end
        # 
      end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
      # add_cart
      @product.destroy

      respond_to do |format|
        format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def stock
      if @product.stock_product == true
        @product.update_attribute(:stock_product, false)
      elsif @product.stock_product == false
        @product.update_attribute(:stock_product, true)
      end
      redirect_to request.referrer
    end
    
    def preorder
      if @product.pre_order == true
        @product.update_attribute(:pre_order, false)
      elsif @product.pre_order == false
        @product.update_attribute(:pre_order, true)
      end
      redirect_to request.referrer
    end

    private
# 
    # def add_cart
    #   quantity = params[:quantity].to_i
    #   total_price = params[:total_price].to_i
    #   # order_end = params[:order_end].to_s
    #   order_start = params[:order_start].to_s
    #   customer = params[:customer].to_s
    #   product_price = params[:product_price].to_i
    #   product_name = params[:product_name].to_s
    #   product_id = params[:product_id].to_i 

    #   user_id = params[:user_id].to_i

    #   @failed = Failed.new(product_id: product_id, customer: customer, product_price: product_price, 
    #                        product_name: product_name, quantity: quantity, total_price: total_price,
    #                        order_start: order_start, user_id: user_id)
    #   if @failed.save
    #   #   removecart
    #   # else
    #     redirect_to request.referrer, notice: @failed.errors.full_messages.to_sentence
    #   end
    # end
# 

      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :price, :description, images: [])
      end

    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
