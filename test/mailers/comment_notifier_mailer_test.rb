# frozen_string_literal: true

require 'test_helper'

class CommentNotifierMailerTest < ActionMailer::TestCase
  def setup
    @post = posts(:one)
    @user = users(:one)
  end

  test 'notifying a new comment' do
    assert_emails 1 do
      CommentNotifierMailer.new_comment(@post, @user).deliver_now
    end
  end
end
