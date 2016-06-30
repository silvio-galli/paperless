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

end
