module Admin
  class HomepagessesController < ApplicationController
    before_action :set_homepagess, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
    before_action :restrict_user_by_role
    before_action :only_one_row_record, only: %i[ new create ]

    # GET /homepagesses/1 or /homepagesses/1.json
    def show
      @records = Homepagess.all
    end

    # GET /homepagesses/new
    def new
      @homepagess = Homepagess.new
    end

    # GET /homepagesses/1/edit
    def edit
    end

    # POST /homepagesses or /homepagesses.json
    def create
      @homepagess = Homepagess.new(homepagess_params)

      respond_to do |format|
        if Homepagess.count > 0
          format.html { redirect_to admin_homepagess_url(Homepagess.first), notice: "You can create only one row of this table" }
          format.json { render :show, status: :created, location: @homepagess }
        else
          if @homepagess.save
            format.html { redirect_to admin_homepagess_url(@homepagess), notice: "Homepagess was successfully created." }
            format.json { render :show, status: :created, location: @homepagess }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @homepagess.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    # PATCH/PUT /homepagesses/1 or /homepagesses/1.json
    def update
      respond_to do |format|
        if @homepagess.update(homepagess_params)
          format.html { redirect_to admin_homepagess_url(@homepagess), notice: "Homepagess was successfully updated." }
          format.json { render :show, status: :ok, location: @homepagess }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @homepagess.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /homepagesses/1 or /homepagesses/1.json
    def destroy
      @homepagess.destroy

      respond_to do |format|
        format.html { redirect_to new_admin_homepagess_url, notice: "Homepagess was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      def only_one_row_record
          redirect_to admin_homepagess_url(Homepagess.first), notice: "You can create only one row of this table" if Homepagess.count > 0
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_homepagess
        @homepagess = Homepagess.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def homepagess_params
        params.require(:homepagess).permit(:brand_name, :title, :description)
      end
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
