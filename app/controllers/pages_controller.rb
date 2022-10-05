class PagesController < ApplicationController
  def home
    @homepagess = Homepagess.first
    @products = Product.all
  end
  def about
    @abouts = About.all
  end
  def messageroom
    @message = Message.new
    if user_signed_in?
      @messages = Message.custom_display
      # @messages = current_user.messages.all    
      # @messages = Message.all
      # @user = User.find_by(id: params[:id])
      # @messages = Message.all
    end
  end
end
