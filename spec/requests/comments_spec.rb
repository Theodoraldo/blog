require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      comment = Comment.reflect_on_association(:author)
      expect(comment.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end

  describe 'update_comment_counter' do
    user = User.create(name: 'Microverse  Commenter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'Collaboratively')
    post = Post.create(title: 'test', text: 'post content', author: user, comments_counter: 0, likes_counter: 0)
    subject = Comment.create(post:, author: user, text: 'Hi Tom!')

    it 'increments the comments counter on the associated post' do
      expect { subject.send(:update_comments_counter) }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
