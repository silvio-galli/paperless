class WelcomeController < ApplicationController
  def index
    @products = Product.all
    @orders = Order.open?
  end

  def about
  end
end
