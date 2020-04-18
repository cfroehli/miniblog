# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post post_comments_url(post_id: @post.id), params: { comment: { content: 'New comment by me' } }
    end
    assert_redirected_to post_url(@post)
  end
end
