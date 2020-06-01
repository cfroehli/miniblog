require 'rails_helper'

describe StatisticsMailer, type: :task do
  subject(:task) { Rake::Task['statistics:send_posts_ranking'] }

  let(:users) { create_list(:user, 10) }
  let(:posts) { create_list(:post, 50, user: users.sample) }

  it 'send the top ranked post detail to each user' do
    users.each do |user|
      posts.sample(20).each do |liked_post|
        user.likes.create(post: liked_post) if liked_post.user != user
      end
    end
    expect { task.invoke }.to change(ActionMailer::Base.deliveries, :count).by(users.size)
    mails = ActionMailer::Base.deliveries
    user_mails = users.map(&:email)
    mails.each do |mail|
      expect(mail.subject).to match(/Miniblog .* top 10 posts ranking./)
      expect(user_mails).to include(*mail.to)
    end
  end
end
