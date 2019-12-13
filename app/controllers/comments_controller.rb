class CommentsController < ApplicationController
  before_action :find_post, only: [:create]
  respond_to :html, :json

  def create
    @comment = @post.comments.create(comment_params)
    send_new_comment_notification
    redirect_to post_path(@post)
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content).merge(user: current_user)
    end

    def send_new_comment_notification
      CommentNotifierMailer.new_comment(@post, current_user).deliver_later
    end
end
