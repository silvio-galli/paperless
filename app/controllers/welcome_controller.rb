class WelcomeController < ApplicationController
  def index
    @products = Product.all.paginate(page: params[:page], per_page: 20)
    @orders = Order.open?.paginate(page: params[:page], per_page: 20)
  end

  def about
  end
end
