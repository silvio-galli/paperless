class OrdersController < ApplicationController
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
      redirect_to edit_order_path(@order)
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

  def subtotal(order)
    order.order_items
  end

  private

  def order_params
    params.require(:order).permit(:notes, :total_price)
  end
end
