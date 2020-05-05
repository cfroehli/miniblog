require 'rails_helper'

describe 'E-Mail notifications' do
  let(:user) { build(:user) }

  context 'when a new comment is added' do
    let(:post) { build(:post) }
    let(:mail) { CommentNotifierMailer.new_comment(post, user) }

    it 'get the correct subject' do
      expect(mail.subject).to eql("Post #{post.id} got a new comment by #{user.username}.")
    end

    it 'is sent to the post author' do
      expect(mail.to).to eql([post.user.email])
    end
  end

  #TODO add statistics mail test
  # create user/posts then run with Rake::Task[].invoke
end
