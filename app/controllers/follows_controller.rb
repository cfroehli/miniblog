class FollowsController < ApplicationController
  before_action :find_user, only: [:create, :destroy]
  respond_to :json, :html

  def create
    if current_user != @user
      follow_link = current_user.followees_link.create(followee: @user)
      if follow_link.save
        flash[:success] = "You're now following #{@user.username}"
      else
        flash[:warning] = "Unable to follow #{@user.username}"
      end
    else
      flash[:warning] = "Following one's self is not allowed"
    end
    respond_with @user
  end

  def destroy
    current_user.followees_link.find_by(followee: @user).destroy
    flash[:success] = "You're no longer following #{@user.username}"
    respond_with @user
  end
end
