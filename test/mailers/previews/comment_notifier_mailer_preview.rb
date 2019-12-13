# Preview all emails at http://localhost:3000/rails/mailers/comment_notifier_mailer
class CommentNotifierMailerPreview < ActionMailer::Preview
  def new_comment
    CommentNotifierMailer.new_comment(Post.first, User.first)
  end
end
