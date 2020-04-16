# frozen_string_literal: true

class FollowsController < ApplicationController
  respond_to :html

  before_action :require_other_user

  def follow
    followed_user = find_user
    follow_link = current_user.followees_link.create(followee: followed_user)
    if follow_link.save
      flash[:success] = "You're now following #{followed_user.username}"
    else
      flash[:warning] = "Unable to follow #{followed_user.username}"
    end
    respond_with followed_user
  end

  def unfollow
    followed_user = find_user
    current_user.followees_link.find_by(followee: followed_user).destroy
    flash[:success] = "You're no longer following #{followed_user.username}"
    respond_with followed_user
  end

  private

  def find_user
    @find_user ||= User.find(params[:id])
  end

  def require_other_user
    followed_user = find_user
    return unless current_user == followed_user

    flash[:warning] = "Following one's self is not allowed"
    respond_with followed_user
  end
end
