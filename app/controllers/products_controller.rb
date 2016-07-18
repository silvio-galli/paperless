class ProductsController < ApplicationController
  require 'csv'
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
      flash[:notice] = t('products.create.flash.notice')
      redirect_to product_path(@product)
    else
      flash[:alert] = t('products.create.flash.alert')
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
      flash[:notice] = t('products.update.flash.notice')
      redirect_to request.referer
    else
      flash[:alert] = t('products.update.flash.alert')
      render :edit
    end
  end

  def import
    products_imported = Product.import(params[:file], current_user)
    flash[:notice] = t('products.import.flash.notice', count: products_imported)
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :status, :arriving_date)
  end

end
