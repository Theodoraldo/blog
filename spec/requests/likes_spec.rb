require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      like = Like.reflect_on_association(:author)
      expect(like.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end

  describe 'update_like_counter' do
    user = User.create(name: 'Microverse  Liker', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Collaboratively')
    post = Post.create(title: 'test', text: 'post content', author: user, comments_counter: 0, likes_counter: 0)
    subject = Like.create(post: post, author: user)

    it 'increments the likes counter on the associated post' do
      expect { subject.send(:update_likes_counter) }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
