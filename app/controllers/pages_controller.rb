class PagesController < ApplicationController
  def home
    @homepagess = Homepagess.first
    @products = Product.all
  end
  def about
  end
end
