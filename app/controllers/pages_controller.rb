class PagesController < ApplicationController
  def home
    @homepagess = Homepagess.first
    @products = Product.all
    # 
    @chatboxes = Chatroom.all
    @customers = User.all
    # 
  end
  def about
    @abouts = About.all
  end
end
