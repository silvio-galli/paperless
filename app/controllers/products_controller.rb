class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:notice] = "Product correctly saved in the database."
      redirect_to product_path(@product)
    else
      flash[:alert] = "Error! Product not saved. Plaese try again."
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes(product_params)

    if @product.save
      if @product.is_arrived?
        SendEmailNotificationJob.set(wait: 1.seconds).perform_later(@product)
      end
      flash[:notice] = "Product correctly updated in the database."
      redirect_to request.referer
    else
      flash[:alert] = "Error! Product not updated. Plaese try again."
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :status, :arriving_date)
  end

end
