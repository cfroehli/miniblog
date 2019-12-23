class StatisticsMailer < ApplicationMailer
  helper :posts

  def posts_ranking(user, posts)
    @user = user
    @posts = posts
    mail(to: @user.email,
         subject: "Miniblog #{DateTime.now.to_s(:update_timestamp)} top 10 posts ranking.")
  end
end
