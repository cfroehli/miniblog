# frozen_string_literal: true

class LikesController < ApplicationController
  respond_to :json, :html

  def create
    @post = find_post
    if current_user != @post.user
      like = current_user.likes.create(post: @post)
      flash[:success] = 'Thank you !' if like.save
    else
      flash[:warning] = "You're not allowed to increment the like counter yourself !"
    end
    respond_with @post
  end

  private

  def find_post
    Post.find(params[:id])
  end
end
