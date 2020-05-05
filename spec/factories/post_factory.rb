FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "Content of post[#{n}] from user[#{user.username}]" }
    association :user
  end
end
