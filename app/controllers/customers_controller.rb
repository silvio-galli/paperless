class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_paper_trail_whodunnit

  def index
    @customers = Customer.all.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:notice] = t('customers.create.flash.notice')
      redirect_to customer_path(@customer)
    else
      flash[:alert] = t('customers.create.flash.alert')
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
      flash[:notice] = t('customers.update.flash.notice')
      redirect_to customer_path(@customer)
    else
      flash[:alert] = t('customers.update.flash.alert')
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
