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

    if @user.update(user_params)
      flash[:notice] = t( 'admin.users.update.flash.notice', user_name: "#{@user.name}")
      redirect_to admin_dashboard_path
    else
      flash[:alert] = t('admin.users.update.flash.alert', user_name: "#{@user.name}")
      redirect_to edit_user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
