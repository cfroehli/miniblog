module UsersHelper
  def user_profile(user)
    user.profile.blank? ? nil : user.profile
  end
end
