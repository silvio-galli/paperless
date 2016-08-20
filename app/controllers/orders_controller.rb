class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_paper_trail_whodunnit

  def index
    @orders = Order.all.page(params[:page])
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @order = Order.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.build(order_params)
    if @order.save
      flash[:notice] = t('orders.create.flash.notice')
      redirect_to order_path(@order)
    else
      flash[:alert] = t('orders.create.flash.alert')
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.new
    @products = Product.all
    @ordered_items = @order.order_items #OrderItem.all.where(order_id: @order.id)
    @total_quantity = (@ordered_items.map { |o| o.quantity }).sum
    @created_items_versions = PaperTrail::Version.where(event: "create", order_item_order_id: @order.id)
    @deleted_items_versions = PaperTrail::Version.where(event: "destroy", order_item_order_id: @order.id)
  end

  def edit
  end

  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(order_params)

    if @order.save
      flash[:notice] = t('orders.update.flash.notice')
      redirect_to request.referer
    else
      flash[:alert] = t('orders.update.flash.alert')
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:notes, :total_price, :status)
  end
end
