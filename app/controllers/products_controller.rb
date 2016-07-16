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
    @products_imported = 0
    CSV.foreach(params[:file].path, headers: true) do |row|
      if I18n.locale == :it
        Product.create(
          initiative: row["Iniziativa"],
          local_code: row["Codice Locale"],
          description: row["Descrizione"],
          barcode: row["Codice a Barre"],
          default_price: row["Prezzo Continuo"],
          promo_price: row["Prezzo Promo"],
          quantity: row["Quantità"],
          status: row["Status"],
          arriving_date: row["Data Arrivo"],
          user: current_user
        )
        @products_imported += 1
      elsif I18n.locale = :en
        Product.create(row.to_hash)
        @products_imported += 1
      end
    end
    flash[:notice] = "#{@products_imported} nuovi prodotti importati"
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :status, :arriving_date)
  end

end
