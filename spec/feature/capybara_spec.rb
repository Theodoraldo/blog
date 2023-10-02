require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  describe 'Should display some text and links' do
    let!(:users) do
      [
        User.create(name: 'Microverse A', photo: 'http://via.placeholder.com/250x250',
                    bio: 'A programmer engineer from Ghana.'),
        User.create(name: 'Microverse B', photo: 'http://via.placeholder.com/250x250',
                    bio: 'A backend developer from Peru.')
      ]
    end

    before do
      visit users_path
    end

    it 'Display header text' do
      expect(page).to have_content('List of all users')
    end

    it 'Display user name text' do
      expect(page).to have_text('Name: Microverse A')
    end

    it 'Display button to go to users page' do
      expect(page).to have_link('View profile')
    end

    it 'displays the username of all other users' do
      users.each do |user|
        expect(page).to have_content("Name: #{user.name}")
      end
    end

    it 'displays the profile picture for each user' do
      users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
      end
    end

    it 'displays the number of post of all other users' do
      users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end

    it 'When I click on the first user, should be redirected to user\'s show page' do
      click_link 'View profile', href: user_path(users[0])
      expect(page).to have_current_path(%r{/users/\d+})
    end

    it 'When I click on the second user, should be redirected to user\'s show page' do
      click_link 'View profile', href: user_path(users[1])
      expect(page).to have_current_path(%r{/users/\d+})
    end
  end
end

RSpec.describe 'User show page', type: :feature do
  describe 'Should display user and their posts' do
    user = User.create(name: 'Theodoraldo Gishun', photo: 'http://via.placeholder.com/250x250',
                       bio: 'A programmer engineer from Ghana.')
    let!(:posts) do
      [
        Post.create(title: 'Arrival', text: 'Post content 1', author: user),
        Post.create(title: 'Departure', text: 'Post content 2', author: user)
      ]
    end

    before do
      visit user_path(user)
    end

    it 'Display header text' do
      expect(page).to have_content('All posts by a user')
    end

    it 'displays the user name and their posts' do
      expect(page).to have_content("Name: #{user.name}")
    end

    it 'displays number of posts a user has made' do
      expect(page).to have_content("Number of posts: #{posts.count}")
    end

    it 'displays the profile picture for each user' do
      expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
    end

    it 'Display bio text' do
      expect(page).to have_content('Bio')
    end

    it 'Display bio content' do
      expect(page).to have_content(user.bio)
    end

    it 'Display first post title' do
      expect(page).to have_content('Arrival')
    end

    it 'Display first post text' do
      expect(page).to have_content('Post content 1')
    end

    it 'Display second post title' do
      expect(page).to have_content('Arrival')
    end

    it 'Display second post text' do
      expect(page).to have_content('Departure')
    end

    it 'Display count of comments and likes' do
      posts.each do |post|
        expect(page).to have_content("Comments : #{post.comments_counter}, Likes : #{post.likes_counter}")
      end
    end

    it 'Display button to show all posts to a user' do
      expect(page).to have_link('See all posts')
    end

    it 'When I click on See all posts, I am redirected to their index page' do
      click_link 'See all posts', href: user_posts_path(user)
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
