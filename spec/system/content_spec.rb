# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Site content management tests :', type: :system, js: true do
  fixtures :users, :posts, :comments

  let(:logged_user) { users(:one) }
  let(:user_post) { posts(:one) }
  let(:other_user_post) { posts(:three) }

  before { sign_in logged_user }

  it 'can create a post' do
    visit root_path
    click_on 'Post new content'
    fill_in 'post-content-area', with: 'ABCDE'
    click_on 'Submit'
    expect(page).to have_text('Post was successfully created.')
    expect(page).to have_text("#{logged_user.username} said:")
    expect(page).to have_selector('div', class: 'card-text', text: 'ABCDE')
  end

  context "when viewing other user's post" do
    before { visit post_path(other_user_post) }

    it 'can write a comment' do
      fill_in 'comment-content-area', with: 'ABCDEFGHI'
      click_on 'Submit'
      expect(page).to have_selector('div', class: 'card-header', text: "#{logged_user.username} said")
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
      click_on 'Submit'
      expect(ActionMailer:: Base.deliveries).not_to be_empty
      mail = ActionMailer:: Base.deliveries.last
      expect(mail.subject).to eq("Post #{user_post.id} got a new comment by #{logged_user.username}.")
      expect(page).to have_selector('div', class: 'card-header', text: "#{logged_user.username} said")
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
