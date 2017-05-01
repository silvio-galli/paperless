class SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  # maybe can be useful to keep imported files available
  # to see what was imported, when and who did it
  # so the callback and the function are commented
  # before_action :delete_imported_files, only: [ :destroy]

  private
  # def delete_imported_files
  #   if current_user.admin?
  #     client_ip_address = current_user.current_sign_in_ip
  #     entries = Dir.glob("public/import/#{client_ip_address}_*.csv")
  #     entries.each do |file|
  #       if File.exists?(file)
  #         File.delete(file)
  #       end
  #     end
  #     puts "Msg for Admin: imported files deleted while signing out."
  #   end
  # end
end
