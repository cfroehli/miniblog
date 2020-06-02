FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "Content of post[#{n}] from user[#{user.username}]" }
    association :user

    trait :with_author do
      user_name { user.username }
    end

    trait :with_image do
      featured_image { File.new(Rails.root.join('spec/fixtures/spintop.jpg')) }
    end

    factory :post_with_author do
      with_author
    end
  end
end
