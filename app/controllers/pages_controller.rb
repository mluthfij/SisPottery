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
      # @messages = current_user.messages.all    
      @messages = Message.all    
    end
  end
end
