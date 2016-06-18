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

  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item.destroy
      flash[:notice] = "Item removed from order"
      redirect_to order_path(@order_item.order_id)
    else
      flash[:alert] = "Item wasn't removed. Please try again."
      redirect_to order_path (@order_item.order_id)
    end
  end
end
