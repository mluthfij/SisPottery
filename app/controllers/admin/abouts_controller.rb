module Admin
  class AboutsController < ApplicationController
    before_action :set_about, only: %i[ show edit update destroy ]
    before_action :authenticate_user!
    before_action :restrict_user_by_role
    # before_action :only_one_row_record, only: %i[ new create ]

    # GET /abouts or /abouts.json
    def index
      @abouts = About.all
      @about = About.new
    end

    # GET /abouts/1 or /abouts/1.json
    # def show
    #   # @records = About.all
    # end

    # GET /abouts/new
    # def new
    #   @about = About.new
    # end

    # GET /abouts/1/edit
    def edit
    end

    # POST /abouts or /abouts.json
    def create
    @about = About.new(about_params)
      if @about.save
        respond_to do |format|
          format.html { redirect_to admin_abouts_url, notice: "About was successfully created." }
          format.json { render :show, status: :created, location: @about }
        end
      else
        redirect_to request.referrer, notice: @about.errors.full_messages.to_sentence
      end
    end

    # PATCH/PUT /abouts/1 or /abouts/1.json
    def update
      respond_to do |format|
        if @about.update(about_params)
          format.html { redirect_to admin_abouts_url, notice: "About was successfully updated." }
          format.json { render :show, status: :ok, location: @about }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @about.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /abouts/1 or /abouts/1.json
    def destroy
      @about.destroy

      respond_to do |format|
        format.html { redirect_to admin_abouts_url, notice: "About was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # def only_one_row_record
      #     redirect_to admin_homepagess_url(About.first), notice: "You can create only one row of this table" if About.count > 0
      # end
      # Use callbacks to share common setup or constraints between actions.
      def set_about
        @about = About.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def about_params
        params.require(:about).permit(:description, :company_name, :sub_title, :title, :image)
      end
    
    protected
    # redirect if user not logged in or does not have a valid role
      def restrict_user_by_role
        redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
      end
  end
end
