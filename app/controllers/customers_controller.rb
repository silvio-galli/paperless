class CustomersController < ApplicationController
  def index
    if params[:search] && params[:search].select { |k, v| v != "" }.empty?
        flash[:alert] = "You did not enter search parameters."
        @customers = Customer.all
        redirect_to customers_path
    elsif params[:search]
        key = params[:search].select { |k, v| v != "" }.keys[0]
        @customers = Customer.where(key => params[:search][key])
    else
      @customers = Customer.all
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:notice] = "Customer added to database."
      redirect customers_path
    else
      flash[:alert] = "No customer added. Please try again."
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.assign_attributes(customer_params)

    if @customer.save
      flash[:notice] = "Customer updated."
      redirect customers_path
    else
      flash[:alert] = "Customer was NOT updated. Please try again."
      render :edit
    end
  end

  def search_by_name(data)
    @customer = Customer.find_by(last_name: data)
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone, :email, :address, :city, :postcode, :country)
  end
end
