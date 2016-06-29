class RegistrationsController < Devise::RegistrationsController
  before_action :require_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  def create
    super #Nothing special here.
  end

  protected

  def sign_up(resource_name, resource)
    true
  end
  
  private
  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You do not have permission to do this."
      redirect_to root_path
    end
  end

end
