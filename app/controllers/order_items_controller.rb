class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :closed_order_cannot_modify
  before_filter :set_paper_trail_whodunnit

  def create
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new
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
  def closed_order_cannot_modify
    if params[:order_id]
      order = Order.find(params[:order_id])
    else
      order = OrderItem.find(params[:id]).order
    end
    if order.closed?
      flash[:alert] = t('order_items.destroy.flash.closed_order_cannot_modify')
      redirect_to request.referrer
    end
  end

end
