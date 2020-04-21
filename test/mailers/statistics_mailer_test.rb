# frozen_string_literal: true

require 'test_helper'

class StatisticsMailerTest < ActionMailer::TestCase
  def setup
    @posts = %i[one two three].map { |id| posts(id).class.with_username.first }
    @user = users(:one)
  end

  test 'send posts ranking' do
    assert_emails 1 do
      StatisticsMailer.posts_ranking(@user, @posts).deliver_now
    end
  end
end
