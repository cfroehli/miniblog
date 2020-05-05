# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Site ACL :', type: :request do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let!(:other_post) { create(:post) }

  context 'when user is not logged' do
    it 'cant delete a post' do
      expect { delete post_path(other_post.id) }.not_to change(Post, :count)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'cant edit a post' do
      patch post_path(other_post.id), params: { content: 'ABC' }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged' do
    before { login_as user, scope: :user }

    it 'cant delete another user post' do
      expect { delete post_path(other_post.id) }
        .to raise_exception(ActiveRecord::RecordNotFound)
        .and change(Post, :count).by(0)
    end

    it 'cant edit another user post' do
      expect { patch post_path(other_post.id), params: { content: 'ABC' } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'cant follow himself' do
      post follows_user_path(id: user.id)
      expect(response).to redirect_to(user_path(id: user.id))
      expect(request.flash[:warning]).to eq("Following one's self is not allowed")
    end

    it 'cant like his post' do
      post likes_path(id: user_post.id)
      expect(response).to redirect_to(post_path(id: user_post.id))
      expect(request.flash[:warning]).to eq("You're not allowed to increment the like counter yourself !")
    end
  end
end
