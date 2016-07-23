class SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  before_action :delete_imported_files, only: [ :destroy]

  private
  def delete_imported_files
    if current_user.admin?
      client_ip_address = current_user.current_sign_in_ip
      entries = Dir.glob("public/import/#{client_ip_address}_*.csv")
      entries.each do |file|
        if File.exists?(file)
          File.delete(file)
        end
      end
      puts "Msg for Admin: imported files deleted while signing out."
    end
  end
end
