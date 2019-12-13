class LikesController < ApplicationController
  before_action :find_post, only: [:create]
  respond_to :json, :html

  def create
    if current_user != @post.user
      like = current_user.likes.create(post: @post)
      if like.save
        flash[:success] = "Thank you !"
      end
    else
      flash[:warning] = "You're not allowed to increment the like counter yourself !"
    end
    respond_with @post
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end


end
