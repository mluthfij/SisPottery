module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    # GET /products or /products.json
    def index
      @products = Product.all
    end

    # GET /products/1 or /products/1.json
    def show
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
      @product.destroy

      respond_to do |format|
        format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :price, :quantity, :description, images: [])
      end

    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
