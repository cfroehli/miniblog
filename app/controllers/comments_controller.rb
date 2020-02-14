class CommentsController < ApplicationController
  respond_to :html, :json

  def create
    @post = find_post
    @comment = @post.comments.create(comment_params)
    send_new_comment_notification
    redirect_to post_path(@post)
  end

  private
  def find_post
    Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end

  def send_new_comment_notification
    CommentNotifierMailer.new_comment(@post, current_user).deliver_later
  end
end
