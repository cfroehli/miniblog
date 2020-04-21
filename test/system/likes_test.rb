# frozen_string_literal: true

require 'application_system_test_case'

class LikesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
  end

  test 'liking a post from main page' do
    visit posts_url
    click_on '+1', match: :first

    assert_selector '.alert-success', text: 'Thank you !'
  end

  test 'liking a post from post page' do
    visit posts(:four)
    click_on '+1', match: :first

    assert_selector '.alert-success', text: 'Thank you !'
  end
end
