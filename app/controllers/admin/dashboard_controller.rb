class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all.where(admin: false)
  end

end
