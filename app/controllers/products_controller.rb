class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

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
      flash[:notice] = "Product correctly updated in the database."
      redirect_to products_path
    else
      flash[:alert] = "Error! Product not updated. Plaese try again."
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :arriving_date)
  end

end
