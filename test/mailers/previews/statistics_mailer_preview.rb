# Preview all emails at http://localhost:3000/rails/mailers/statistics_mailer
class StatisticsMailerPreview < ActionMailer::Preview
  def posts_ranking
    posts = Post
      .limit(10)
      .joins(:user)
      .select('posts.*, users.username as user_name')
    StatisticsMailer.posts_ranking(User.first, posts)
  end
end
