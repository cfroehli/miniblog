FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    email { "#{username}@server.com" }
    blog_url { "http://#{username}.blog.com" }
    profile { "This is #{username}'s profile." }
    password { 'password' }
  end
end
