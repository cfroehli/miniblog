# frozen_string_literal: true

module UsersHelper
  def user_profile(user)
    profile = user.profile
    profile.presence || profile
  end
end
