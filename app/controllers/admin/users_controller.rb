class Admin::UsersController < ApplicationController
  before_action :require_admin

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # I want admin to update only password
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      flash[:notice] = "#{@user.name} has a new password"
      redirect_to admin_dashboard_path
    else
      flash[:alert] = "There was an error. Please try again ."
      redirect_to edit_user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
