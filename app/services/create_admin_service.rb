class CreateAdminService
  def call
    User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
      user.username = ENV["ADMIN_USERNAME"]
      user.password = ENV["ADMIN_PASSWORD"]
      user.password_confirmation = ENV["ADMIN_PASSWORD"]
      user.try(:confirm!)
      user.admin!
    end
  end
end
