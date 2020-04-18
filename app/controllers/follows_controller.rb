# frozen_string_literal: true

class FollowsController < ApplicationController
  respond_to :html

  before_action :require_other_user

  def follow
    followed_user = find_user
    follow_link = current_user.followees_link.create(followee: followed_user)
    flash[:success] = "You're now following #{followed_user.username}" if follow_link.save
    respond_with followed_user
  end

  def unfollow
    followed_user = find_user
    followee = current_user.followees_link.find_by(followee: followed_user)
    flash[:success] = "You're no longer following #{followed_user.username}" if followee.destroy
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
