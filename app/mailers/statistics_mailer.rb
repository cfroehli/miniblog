# frozen_string_literal: true

class StatisticsMailer < ApplicationMailer
  helper :posts

  def posts_ranking(user, posts)
    @user = user
    @posts = posts
    mail(to: @user.email,
         subject: "Miniblog #{DateTime.now.to_s(:timestamp)} top 10 posts ranking.")
  end
end
