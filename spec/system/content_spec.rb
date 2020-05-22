# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Site content :', type: :system, js: true do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let(:other_user_post) { create(:post) }

  before { sign_in user }

  it 'can create a post' do
    visit root_path
    click_on 'Post new content'
    fill_in 'post-content-area', with: 'ABCDE'
    click_on 'Submit'
    expect(page).to have_text('Post was successfully created.')
    expect(page).to have_text("#{user.username} said:")
    expect(page).to have_selector('div', class: 'card-text', text: 'ABCDE')
  end

  context "when viewing other user's post" do
    before { visit post_path(other_user_post) }

    it 'can write a comment' do
      fill_in 'comment-content-area', with: 'ABCDEFGHI'
      click_on 'Submit'
      expect(page).to have_selector('div', class: 'card-header', text: "#{user.username} said")
      expect(page).to have_selector('div', class: 'card-text', text: 'ABCDEFGHI')
    end

    it 'cant be edited' do
      expect(page).not_to have_text('Edit post')
    end

    it 'cant be deleted' do
      expect(page).not_to have_text('Delete post')
    end
  end

  context 'when viewing own post' do
    before { visit post_path(user_post) }

    it 'can write a comment' do
      fill_in 'comment-content-area', with: 'ABCDEFGHI'
      expect { click_on 'Submit' }.to change(ActionMailer::Base.deliveries, :count).by(1)
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq("Post #{user_post.id} got a new comment by #{user.username}.")
      expect(page).to have_selector('div', class: 'card-header', text: "#{user.username} said")
      expect(page).to have_selector('div', class: 'card-text', text: 'ABCDEFGHI')
    end

    it 'can be deleted' do
      page.accept_confirm('Are you sure?') { click_on 'Delete post' }
      expect(page).to have_text('Post was successfully destroyed.')
      expect(page).to have_current_path(posts_path)
      expect(page).not_to have_text(user_post.content)
    end

    it 'can be edited' do
      click_on 'Edit post'
      fill_in 'post-content-area', with: 'ABCDEF'
      click_on 'Submit'
      expect(page).to have_text('Post was successfully updated.')
      expect(page).to have_selector('div', class: 'card-text', text: 'ABCDEF')
    end

    it 'cant be liked' do
      expect(page).not_to have_text('+1')
    end
  end
end
