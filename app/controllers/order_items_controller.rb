class OrderItemsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @order_item =OrderItem.new
    @order_item.order_id = @order.id
    @order_item.product_id = params[:order_item][:product_id]
    @order_item.quantity = params[:order_item][:quantity]

    if @order_item.save
      flash[:notice] = "Item added to order."
      redirect_to order_path(@order_item.order)
    else
      flash[:alert] = "No item added. Please try again."
      redirect_to order_path(@order_item.order)
    end
  end
end
