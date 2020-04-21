# frozen_string_literal: true

require 'application_system_test_case'

class LikesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
  end

  test 'following a user' do
    visit posts_url
    click_on 'Follow', match: :first, exact: true
    assert_selector '.alert-success', text: "You're now following"
  end

  test 'unfollow a user' do
    visit posts_url
    click_on 'Followed', match: :first
    click_on 'Unfollow', match: :first

    assert_selector '.alert-success', text: "You're no longer following"
  end
end
