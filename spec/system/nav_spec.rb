# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Site navigation :', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:followed_user) { create(:user) }
  let!(:other_user) { create(:user) }

  before { sign_in user }

  context 'when listing users' do
    before { visit users_path }

    it "shows user's infocard" do
      aggregate_failures do
        [user, followed_user, other_user].each do |current_user|
          expect(page).to have_selector('h1', text: current_user.username, visible: :all)
          expect(page).to have_selector('a', text: current_user.blog_url, visible: :all)
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
      expect(page).to have_text(user.username)

      click_on 'Unfollow', match: :prefer_exact
      expect(page).to have_text("You're no longer following #{other_user.username}")
      expect(page).to have_selector('a', text: 'Follow')
      expect(page).not_to have_text(user.username)
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
    let!(:liked_posts) { create_list(:post, 3, user: other_user, liking_users: [user]) }
    let!(:other_posts) { create_list(:post, 3) }

    before do
      visit root_path
      click_on 'Liked', match: :prefer_exact
    end

    it 'does not display unliked posts' do
      aggregate_failures do
        other_posts.each do |post|
          expect(page).not_to have_text(post.content)
        end
      end
    end

    it 'displays liked posts' do
      aggregate_failures do
        liked_posts.each do |post|
          expect(page).to have_text(post.content)
        end
      end
    end
  end

  context 'when listing posts' do
    before do
      create_list(:post, 3, user: other_user)
      visit root_path
    end

    it 'can like a post' do
      click_on '+1', match: :first
      expect(page).to have_text('Thank you !')
    end
  end
end
