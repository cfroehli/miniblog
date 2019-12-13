class CommentNotifierMailer < ApplicationMailer
  default from: ENV.fetch('EMAIL_NOTIFICATION_FROM') { 'invalid@invalid.com' }

  def new_comment(post, by_user)
    @post = post
    mail(to: @post.user.email,
         subject: "Post #{post.id} got a new comment by #{by_user.username}.")
  end
end
