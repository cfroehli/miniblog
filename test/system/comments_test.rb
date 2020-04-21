# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
  end

  test 'create a comment' do
    visit posts_url
    click_on 'View full post', match: :first

    fill_in 'comment-content-area', with: 'Commenting this post'
    click_on 'Submit'

    assert_selector '.card-text', text: 'Commenting this post'
  end
end
