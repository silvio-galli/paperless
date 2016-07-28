class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_paper_trail_whodunnit

  def index
    @products = Product.all.page(params[:page])
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
    @versions = PaperTrail::Version.where(item_id: @product.id).order('id desc')
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
    flash[:notice] =  t('products.update.flash.notice')
      if request.referer.include? "edit"
        redirect_to product_path(@product)
      else
        redirect_to request.referer
      end
    else
      flash[:alert] = t('products.update.flash.alert')
      render :edit
    end
  end

  def import
    uploaded_file = params[:file]
    client_ip_address = request.remote_ip
    time_stamp = Time.now.strftime("%d%m%Y%H%M%S")
    file_name = "#{client_ip_address}_#{time_stamp}.csv"
    file_path = Rails.root.join('public', 'import', file_name)
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    ImportProductsFromCsvJob.set(wait: 1.seconds).perform_later("public/import/#{file_name}", current_user)
    flash[:notice] = t('products.import.flash.notice')
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :status, :arriving_date)
  end

end
