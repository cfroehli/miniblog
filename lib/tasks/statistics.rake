namespace :statistics do
  desc 'Send top 10 posts ranking'
  task send_posts_ranking: :environment do
    posts = Post
              .where('posts.likes_count > 0')
              .order(likes_count: :desc, updated_at: :desc)
              .limit(10)
              .joins(:user)
              .select('posts.*, users.username as user_name').to_a
    unless posts.empty?
      User.all.each do |user|
        StatisticsMailer.posts_ranking(user, posts).deliver
      end
    end
  end
end
