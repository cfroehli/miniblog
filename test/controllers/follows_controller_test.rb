# frozen_string_literal: true

require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest 
  test 'should follow' do
    sign_in users(:two)
    other_user = users(:one)
    assert_difference('Follow.count') do
      post follows_user_url(other_user)
    end
    assert_redirected_to user_url(other_user)
  end

  test 'should unfollow' do
    sign_in users(:one)
    other_user = users(:two)
    assert_difference('Follow.count', -1) do
      delete follows_user_url(other_user)
    end
    assert_redirected_to user_url(other_user)
  end

  test 'should forbid own follow' do
    user = users(:one)
    sign_in user
    assert_difference('Follow.count', 0) do
      post follows_user_url(user)
    end
    assert_redirected_to user_url(user)
  end

  test 'should forbid duplicated follow' do
    sign_in users(:one)
    other_user = users(:two)
    assert_raises(ActiveRecord::RecordNotUnique) do
      post follows_user_url(other_user)
    end
  end
end
