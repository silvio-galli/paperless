class WelcomeController < ApplicationController
  def index
    @products = Product.all # TODO scope model based on delivery status (e.i. arriving, arrived)
    @orders = Order.all # TODO scope model based on order status (e.i. open, closed)
  end

  def about
  end
end
