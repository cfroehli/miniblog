# frozen_string_literal: true

module UsersHelper
  def user_profile(user)
    user.profile.presence || user.profile
  end
end
