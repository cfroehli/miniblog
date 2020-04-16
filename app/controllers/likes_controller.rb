# frozen_string_literal: true

class LikesController < ApplicationController
  respond_to :html

  before_action :forbid_own_post, only: %i[create]

  def create
    post = liked_post
    like = current_user.likes.create(post: post)
    if like.save
      flash[:success] = 'Thank you !'
    else
      flash[:warning] = "Unable to register 'like' to post #{post.id}"
    end
    respond_with post
  end

  private
  def liked_post
    @liked_post ||= Post.find(params[:id])
  end

  def forbid_own_post
    post = liked_post
    if current_user == post.user
      flash[:warning] = "You're not allowed to increment the like counter yourself !"
      respond_with post
    end
  end
end
