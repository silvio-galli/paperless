class OrderItemsController < ApplicationController
  before_action :closed_order_cannot_add_item, only: [ :create ]
  before_action :closed_order_cannot_remove_item, only: [ :destroy ]

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @order_item.order_id = @order.id
    @order_item.product_id = params[:order_item][:product_id]
    @order_item.quantity = params[:order_item][:quantity]

    if @order_item.save
      flash[:notice] = t('order_items.create.flash.notice')
      redirect_to order_path(@order_item.order)
    else
      flash[:alert] = t('order_items.create.flash.alert')
      redirect_to order_path(@order_item.order)
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item.destroy
      flash[:notice] = t('order_items.destroy.flash.notice')
      redirect_to order_path(@order_item.order_id)
    else
      flash[:alert] = t('order_items.destroy.flash.alert')
      redirect_to order_path (@order_item.order_id)
    end
  end

  private
  def closed_order_cannot_add_item
    order = Order.find(params[:order_id])
    if order.closed?
      flash[:alert] = t('order_items.destroy.flash.closed_order_cannot_modify')
      redirect_to request.referrer
    end
  end

  def closed_order_cannot_remove_item
    order = OrderItem.find(params[:id]).order
    if order.closed?
      flash[:alert] = t('order_items.destroy.flash.closed_order_cannot_modify')
      redirect_to request.referrer
    end
  end

end
