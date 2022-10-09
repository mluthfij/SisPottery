class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: %i[ show edit update destroy ]
  before_action :correct_user, only: %i[ edit update destroy ] 
  before_action :only_one_row_record, only: %i[ new create ]

  # GET /chatrooms or /chatrooms.json
  def index
    # @chatrooms = Chatroom.all
    @chatrooms = current_user.chatrooms.all
  end

  # GET /chatrooms/1 or /chatrooms/1.json
  def show
    # 
    @message = Message.new
    if user_signed_in?
      # @messages = Message.custom_display
      @messages = @chatroom.messages.custom_display
    end
    # 
  end

  # GET /chatrooms/new
  def new
    # @chatroom = Chatroom.new
    @chatroom = current_user.chatrooms.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms or /chatrooms.json
  def create
    @chatroom = current_user.chatrooms.new(chatroom_params)

    respond_to do |format|
      if current_user.chatrooms.count > 0
          format.html { redirect_to admin_homepagess_url(current_user.chatrooms.first), notice: "You can create only one row of this table" }
          format.json { render :show, status: :created, location: @chatroom }
      else
        if @chatroom.save
          format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully created." }
          format.json { render :show, status: :created, location: @chatroom }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @chatroom.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /chatrooms/1 or /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully updated." }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1 or /chatrooms/1.json
  def destroy
    @chatroom.destroy

    respond_to do |format|
      format.html { redirect_to new_chatroom_url, notice: "Chatroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @chatroom = current_user.chatrooms.find_by(id: params[:id])
      redirect_to request.referrer, notice: "Not authorized to see this chat." if @chatroom.nil?
    end

    def only_one_row_record
        redirect_to chatroom_url(current_user.chatrooms.first), notice: "You can create only one row of this table" if current_user.chatrooms.count > 0
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chatroom_params
      params.require(:chatroom).permit(:topic, :user_id)
    end
end
