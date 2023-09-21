require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  user = User.create(name: 'Theodoraldo', photo: 'photo_url', posts_counter: 0, bio: 'Teacher from Ghana.')
  post = Post.create(title: 'Test', text: 'Post content', comments_counter: 0, likes_counter: 0, author_id: user.id)

  describe 'validations' do
    it 'title should be present' do
      post.title = nil
      expect(post.title).to_not eq('')
    end

    it 'comments cannot be less than zero' do
      post.comments_counter = -10
      expect(post.comments_counter).not_to eq(0)
    end

    it 'likes cannot be less than zero' do
      post.likes_counter = -2
      expect(post.likes_counter).not_to eq(0)
    end
  end

  describe 'associations' do
    it 'belongs to author' do
      post = Post.reflect_on_association(:author)
      expect(post.macro).to eq(:belongs_to)
    end

    it 'has many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eq(:has_many)
    end

    it 'has many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eq(:has_many)
    end
  end

  describe '#recent_posts methods checked' do
    it 'returns the three most recent comments' do
      user = User.create(name: 'Theodore', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      first_post = Post.create(author: user, title: 'Hi, am back', text: 'This is my post', created_at: Time.current)
      Comment.create(post: first_post, author: user, text: 'Comment one!')
      comment_two = Comment.create(post: first_post, author: user, text: 'Comment two!')
      comment_three = Comment.create(post: first_post, author: user, text: 'Comment three!')
      comment_four = Comment.create(post: first_post, author: user, text: 'Comment four!')
      comment_five = Comment.create(post: first_post, author: user, text: 'Comment five!')
      comment_six = Comment.create(post: first_post, author: user, text: 'Comment six!')

      recent_comment = first_post.recent_comments_post.to_a
      expect(recent_comment).to eq([comment_six, comment_five, comment_four, comment_three, comment_two])
    end

    it 'returns the specified number of recent comments' do
      user_one = User.create(name: 'Ernesto', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      last_post = Post.create(author: user_one, title: 'Hello there are you OK', text: 'This is my eighth post',
                              created_at: Time.current)
      Comment.create(post: last_post, author: user_one, text: 'Comment one!')
      Comment.create(post: last_post, author: user_one, text: 'Comment two!')
      Comment.create(post: last_post, author: user_one, text: 'Comment three!')
      Comment.create(post: last_post, author: user_one, text: 'Comment four!')

      recent_comment = last_post.recent_comments_post(2)
      expect(recent_comment.size).to eq(2)
    end
  end

  describe 'update_posts_counter' do
    user_two = User.create(name: 'Microverse  Post', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Testing experts')
    subject = Post.create(title: 'test', text: 'post content', author: user_two, comments_counter: 0, likes_counter: 0)

    it 'increments the post counter on the associated post' do
      expect { subject.send(:update_user_post_count) }.to change { user_two.reload.posts_counter }.by(1)
    end
  end
end
