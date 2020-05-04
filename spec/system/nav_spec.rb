# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Site navigation tests :', type: :system, js: true do
  fixtures :users, :posts, :likes, :follows

  let(:logged_user) { users(:one) }
  let(:followed_user) { users(:two) }
  let(:other_user) { users(:three) }

  before { sign_in logged_user }

  context 'when listing users' do
    before { visit users_path }

    it "shows user's infocard" do
      aggregate_failures do
        [logged_user, followed_user, other_user].each do |user|
          expect(page).to have_selector('h1', text: user.username, visible: false)
          expect(page).to have_selector('a', text: user.blog_url, visible: false)
        end
      end
    end
  end

  context 'when displaying a user profile' do
    before { visit user_path(other_user) }

    it 'shows user profile' do
      aggregate_failures do
        expect(page).to have_text("#{other_user.username} 's profile")
        expect(page).to have_text(other_user.profile)
      end
    end

    it 'can be followed/unfollowed' do
      click_on 'Follow', match: :prefer_exact
      expect(page).to have_text("You're now following #{other_user.username}")
      expect(page).to have_selector('a', text: 'Unfollow')
      expect(page).to have_text(logged_user.username)

      click_on 'Unfollow', match: :prefer_exact
      expect(page).to have_text("You're no longer following #{other_user.username}")
      expect(page).to have_selector('a', text: 'Follow')
      expect(page).not_to have_text(logged_user.username)
    end
  end

  context 'when following' do
    before do
      visit root_path
      click_on 'Followed', match: :prefer_exact
    end

    it 'does not display other users posts' do
      expect(page).not_to have_text("#{other_user.username} said")
    end

    it 'displays followed posts' do
      followed_user.posts.each do |post|
        expect(page).to have_selector('div', class: 'card-text', text: post.content)
      end
    end
  end

  context 'when liked post exists' do
    before do
      visit root_path
      click_on 'Liked', match: :prefer_exact
    end

    it 'does not display unliked posts' do
      expect(page).not_to have_text('second post content by two')
    end

    it 'displays liked posts' do
      expect(page).to have_text('first post content by two')
    end
  end

  context 'when listing posts' do
    before { visit root_path }

    it 'can like a post' do
      click_on '+1', match: :first
      expect(page).to have_text('Thank you !')
    end
  end
end
