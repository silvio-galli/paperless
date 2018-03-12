class RegistrationsController < Devise::RegistrationsController
  # allow only admin to create new user
  before_action :require_admin, only: [:new, :create]

  # require_no_authentication method is located in
  # https://github.com/plataformatec/devise/blob/master/app/controllers/devise_controller.rb
  # Devise do not allow logged in users to access
  # app/views/registrations/edit and
  # app/views/sessions/new
  # to allow admin logged in user to create new user
  skip_before_action :require_no_authentication, only: [:new, :create]

  def create
    super
  end

  protected

  def sign_up(resource_name, resource)
    true
  end

  # allow users to update attributes without provinding their password
  # :current_password field in db
=begin
  def update_resource(resource, permitted_params)
    resource.update_without_password(params)
  end

  private
  def permitted_params
    params[:user].permit(:first_name, :last_name, :address)
  end
=end

end
