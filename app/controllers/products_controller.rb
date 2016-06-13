class ProductsController < ApplicationController
  def index
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

  def edit
  end

  private
  def product_params
    params.require(:product).permit(:initiative, :local_code, :description, :barcode, :default_price, :promo_price, :quantity, :arriving_date)
  end

end
