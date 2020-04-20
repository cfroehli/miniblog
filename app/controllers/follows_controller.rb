# frozen_string_literal: true

class FollowsController < ApplicationController
  respond_to :html

  before_action :set_followed_user
  before_action :require_other_user

  def follow
    follow_link = current_user.followees_link.create(followee: @followed_user)
    flash[:success] = "You're now following #{@followed_user.username}" if follow_link.save
    respond_with @followed_user
  end

  def unfollow
    followee = current_user.followees_link.find_by(followee: @followed_user)
    flash[:success] = "You're no longer following #{@followed_user.username}" if followee.destroy
    respond_with @followed_user
  end

  private

  def set_followed_user
    @followed_user = User.find(params[:id])
  end

  def require_other_user
    return unless current_user == @followed_user

    flash[:warning] = "Following one's self is not allowed"
    respond_with @followed_user
  end
end
