# frozen_string_literal: true

users = %w[toto titi tutu].map do |username|
  User.create(
    username: username,
    email: "#{username}@hazeliris.com",
    password: "#{username}pass"
  )
end

fake_contents = 'eaiouy'.chars.map { |c| (["bl#{c}" * 3] * 3).join(' ') }

500.times do
  post = Post.create(
    content: fake_contents.sample(3).join(' '),
    user: users.sample(1).first
  )
  post.update_attribute :updated_at, (rand * 30).days.ago # rubocop:disable Rails/SkipsModelValidations
end
