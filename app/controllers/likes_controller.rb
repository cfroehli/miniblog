class LikesController < ApplicationController
  respond_to :json, :html

  def create
    @post = Post.find(params[:id])
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
end
