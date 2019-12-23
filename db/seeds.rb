# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = ['toto', 'titi', 'tutu'].map do |username|
  User.create(
    username: username,
    email: "#{username}@hazeliris.com",
    password: "#{username}pass")
end

fake_contents = 'eaiouy'.chars.map { |c| (["bl#{c}"*3]*3).join(' ') }

500.times do
  post = Post.create(
    content: fake_contents.sample(3).join(' '),
    user: users.sample(1).first)
  post.update_attribute :updated_at, (rand*30).days.ago
end
