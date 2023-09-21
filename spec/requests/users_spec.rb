require 'rails_helper'

RSpec.describe 'Users', type: :request do

  user = User.create(name: 'Theodoraldo', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')

  describe 'validations' do
    it 'name should be present' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'post_count to be greater or equal to zero' do
      user.posts_counter = -1
      expect(user).not_to be_valid
    end

    it 'post_count should be number' do
      user.posts_counter = 'Text'
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe '#recent_posts methods checked' do
    it 'returns the three most recent posts' do
      userA = User.create(name: 'Boat', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      post1 = Post.create(author: userA, title: 'Hey', text: 'This is my first post', created_at: 3.days.ago)
      post2 = Post.create(author: userA, title: 'Hello', text: 'This is my second post', created_at: 2.days.ago)
      post3 = Post.create(author: userA, title: 'Hey there', text: 'This is my third post', created_at: 1.day.ago)
      post4 = Post.create(author: userA, title: 'Hello there', text: 'This is my fourth post', created_at: Time.current)
     
      recent_post = userA.recent_posts.to_a
      expect(recent_post).to eq([post4, post3, post2])
    end

    it 'returns the specified number of recent posts' do
      userB = User.create(name: 'Ernesto', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      post5 = Post.create(author: userB, title: 'Hey', text: 'This is my fifth post', created_at: 3.days.ago)
      post6 = Post.create(author: userB, title: 'Hello', text: 'This is my sixth post', created_at: 2.days.ago)
      post7 = Post.create(author: userB, title: 'Hey there', text: 'This is my seventh post', created_at: 1.day.ago)
      post8 = Post.create(author: userB, title: 'Hello there', text: 'This is my eighth post', created_at: Time.current)
     
      recent_post = userB.recent_posts(4)
      expect(recent_post.size).to eq(4)
    end
  end
end