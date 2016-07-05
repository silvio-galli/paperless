class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @order = Order.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.build(order_params)
    if @order.save
      flash[:notice] = "Order successfully saved."
      redirect_to order_path(@order)
    else
      flash[:alert] = "Order NOT saved. Please try again."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.new
    @products = Product.all
    @ordered_items = OrderItem.all.where(order_id: @order.id)
    @total_quantity = (@ordered_items.map { |o| o.quantity }).sum
  end

  def edit
  end

  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(order_params)

    if @order.save
      flash[:notice] = "Order correctly updated in the database."
      redirect_to request.referer
    else
      flash[:alert] = "Error! Order not updated. Plaese try again."
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:notes, :total_price, :status)
  end
end
