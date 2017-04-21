class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  #FIXME Redirects user to admin/dashboard if admin or welcome/index if not admin after signing in
  def after_sign_in_path_for(resource)
    welcome_path
  end

  protected
  # no use for email parameter in this app (users are not supposed to have an email address)
  #FIXME Devise::ParameterSanitizer#for(sign_up) is deprecated
  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :password, :password_confirmation, :remember_me) }
  end

  private
  # call to prevent non admin users to access resources
  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = t 'registrations.new.flash.require_admin'
      redirect_to root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
