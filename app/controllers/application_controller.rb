class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirects user to users#index if admin or orders#index if not admin after signing in
  def after_sign_in_path_for(resource)
    welcome_index_path
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  end

  private
  # call to prevent non admin users to access resources
  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You do not have permission to do this."
      redirect_to root_path
    end
  end

end
