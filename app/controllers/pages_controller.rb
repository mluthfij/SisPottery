class PagesController < ApplicationController
  def home
    @homepagess = Homepagess.first
    @products = Product.all
  end
  def about
    @abouts = About.all
  end
  # def messageroom
  #   @message = Message.new
  # end
end
