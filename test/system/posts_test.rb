# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @posts = %i[one two three].map { |id| posts(id) }
    sign_in @user
  end

  test 'visiting the index' do
    visit posts_url
    @posts.each do |post|
      assert_text post.content
    end
  end

  test 'creating a Post' do
    visit posts_url
    click_on 'Post new content'

    fill_in 'post-content-area', with: 'test post content'
    click_on 'Submit'

    assert_text 'Post was successfully created.'
  end

  test 'updating a Post' do
    visit posts_url
    click_on 'Edit post', match: :first

    fill_in 'post-content-area', with: 'test post content'
    click_on 'Submit'

    assert_text 'Post was successfully updated.'
  end

  test 'destroying a Post' do
    visit posts_url
    page.accept_confirm do
      click_on 'Delete post', match: :first
    end

    assert_text 'Post was successfully destroyed.'
  end
end
