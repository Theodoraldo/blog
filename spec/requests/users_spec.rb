require 'rails_helper'

RSpec.describe 'Users', type: :request do
  #============================================================================================================
  # describe model test features begins Here
  #============================================================================================================
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
      user_a = User.create(name: 'Boat', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      Post.create(author: user_a, title: 'Hey', text: 'This is my first post', created_at: 3.days.ago)
      post_two = Post.create(author: user_a, title: 'Hello', text: 'This is my second post', created_at: 2.days.ago)
      post_three = Post.create(author: user_a, title: 'Hey there', text: 'This is my third post', created_at: 1.day.ago)
      post_four = Post.create(author: user_a, title: 'Hello there', text: 'This is my fourth post',
                              created_at: Time.current)

      recent_post = user_a.recent_posts.to_a
      expect(recent_post).to eq([post_four, post_three, post_two])
    end

    it 'returns the specified number of recent posts' do
      user_b = User.create(name: 'Ernesto', photo: 'photo_url', posts_counter: 0, bio: 'A programmer from Ghana.')
      Post.create(author: user_b, title: 'Hey', text: 'This is my fifth post', created_at: 3.days.ago)
      Post.create(author: user_b, title: 'Hello', text: 'This is my sixth post', created_at: 2.days.ago)
      Post.create(author: user_b, title: 'Hey there', text: 'This is my seventh post', created_at: 1.day.ago)
      Post.create(author: user_b, title: 'Hello there', text: 'This is my eighth post', created_at: Time.current)

      recent_post = user_b.recent_posts(4)
      expect(recent_post.size).to eq(4)
    end
  end
  #============================================================================================================
  # describe model test features ends Here
  #============================================================================================================


  #============================================================================================================
  # describe controller test features begins Here
  #============================================================================================================
  describe 'GET /users#index' do
    it 'if response status code is correct for users index page' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'should render the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'check if the response body includes text(index) for index page' do
      get users_path
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /users#show' do
    user_z = User.create(name: 'Peprah', photo: 'photo_url', posts_counter: 0, bio: 'A designer from Ghana.')
    it 'if response status code is correct for user show page' do
      get user_path(id: user_z)
      expect(response).to have_http_status(200)
    end

    it 'check if the response body includes text(show) for user show page' do
      get user_path(id: user_z)
      expect(response.body).to include('All posts by a user')
    end

    it 'should render the show template' do
      get user_path(id: user_z)
      expect(response).to render_template(:show)
    end
  end
  #============================================================================================================
  # describe controller test features ends Here
  #============================================================================================================
end
