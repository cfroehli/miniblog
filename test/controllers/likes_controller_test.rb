# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest 
  test 'should create like' do
    sign_in users(:two)
    other_post = posts(:two)
    assert_difference('Like.count') do
      post likes_url, params: { id: other_post.id }
    end
    assert_redirected_to post_url(other_post)
  end

  test 'should forbid own like' do
    sign_in users(:one)
    own_post = posts(:one)
    assert_difference('Like.count', 0) do
      post likes_url, params: { id: own_post.id }
    end
    assert_redirected_to post_url(own_post)
  end

  test 'should forbid duplicated like' do
    sign_in users(:one)
    already_liked_post = posts(:three)
    assert_raises(ActiveRecord::RecordNotUnique) do
      post likes_url, params: { id: already_liked_post.id }
    end
  end
end
