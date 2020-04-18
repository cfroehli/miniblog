# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @users = %i[one two].map { |id| users(id) }
    sign_in @users[0]
  end

  test 'displaying all users' do
    visit users_url
    @users.each do |user|
      assert_selector 'h1', text: user.username, visible: false
      assert_selector 'a', text: user.blog_url, visible: false
    end
  end

  test 'displaying a user profile' do
    visit posts_url
    user = @users[0]
    click_on user.username, match: :first
    assert_text "#{user.username} 's profile"
    assert_text user.profile
  end
end
