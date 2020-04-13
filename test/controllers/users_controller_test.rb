# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'should get index' do
    sign_in @user
    get users_url
    assert_response :success
  end
end
