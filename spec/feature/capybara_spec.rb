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

RSpec.describe 'post index page', type: :feature do
  describe 'Should display user and their posts' do
    user = User.create(name: 'Emmanuella Ansah', photo: 'http://via.placeholder.com/250x250',
                       bio: 'A programmer engineer from Ghana.')
    let!(:posts) do
      [
        Post.create(title: 'Birth rate', text: 'Post content 1', author: user),
        Post.create(title: 'Death rate', text: 'Post content 2', author: user)
      ]
    end

    let(:comments) do
      [
        Comment.create(text: 'First comment for birth rate post', author: user, post: posts[0]),
        Comment.create(text: 'Second comment for death rate post', author: user, post: posts[1])
      ]
    end

    before do
      visit user_posts_path(user)
    end

    it 'Display header text' do
      expect(page).to have_content('List of all posts')
    end

    it 'displays the user name and their posts' do
      expect(page).to have_content("Name: #{user.name}")
    end

    it 'displays the profile picture for each user' do
      expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
    end

    it 'displays number of posts a user has made' do
      expect(page).to have_content("Number of posts: #{posts.count}")
    end

    it 'displays link to new post form' do
      expect(page).to have_link('New Post')
    end

    it 'Display count of comments and likes' do
      posts.each do |post|
        expect(page).to have_content("Comments : #{post.comments_counter}, Likes : #{post.likes_counter}")
      end
    end

    it 'Display post title in all posts' do
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'Display post text content in all posts' do
      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'Displays link to show details of post' do
      expect(page).to have_link('Show details')
    end

    it 'Display pagination link' do
      expect(page).to have_link('Pagination')
    end

    it 'When I click on New post will be redirected to new post form' do
      click_link 'New Post', href: new_post_path
      expect(page).to have_current_path(new_post_path)
    end

    it 'When I click on Show details link, I am redirected to their post show page' do
      click_link 'Show details', href: user_post_path(user, posts[0])
      expect(page).to have_current_path(user_post_path(user, posts[0]))
    end
  end
end

RSpec.describe 'Post show page', type: :feature do
  describe 'Should display post details of a user' do
    user = User.create(name: 'Douglas Opoku', photo: 'http://via.placeholder.com/250x250',
                       bio: 'A programmer engineer from USA.')
    let!(:posts) do
      Post.create(title: 'Birth rate', text: 'Post content 1', author: user)
    end

    let(:comments) do
      Comment.create(text: 'Second comment for death rate post', author: user, post: posts)
    end

    before do
      visit user_post_path(user, posts)
    end

    it 'Display header text' do
      expect(page).to have_content('Detailed posts for a user')
    end

    it 'Display post title by an author' do
      expect(page).to have_content("#{posts.title} by #{posts.author.name}")
    end

    it 'Display count of comments and likes' do
      expect(page).to have_content("Comments : #{posts.comments_counter}, Likes : #{posts.likes_counter}")
    end

    it 'Display post text by an author' do
      expect(page).to have_content(posts.text.to_s)
    end

    it 'Display button to like the post' do
      expect(page).to have_button('Like Post')
    end

    it 'like the post' do
      click_button 'Like Post'

      expect(page).to have_current_path(%r{/users/\d+/posts/\d+})

      expect(page).to have_content('You just liked this post')
    end

    it 'Display button to comment the post' do
      expect(page).to have_button('Save Comment')
    end

    it 'comment the post' do
      fill_in 'comment_text', with: 'Test comment for the post above'

      click_button 'Save Comment'

      expect(page).to have_current_path(%r{/users/\d+/posts/\d+})
      expect(page).to have_content('Comment was successfully created.')
    end

    it 'Display button to go back to all posts' do
      expect(page).to have_link('Back to all posts')
    end

    it 'Redirect to user\'s posts' do
      click_link 'Back to all posts'
      expect(page).to have_current_path(%r{/users/\d+/posts})
    end
  end
end

RSpec.describe 'New post page', type: :feature do
  describe 'Should display and submit form,' do
    before do
      visit new_post_path
    end

    it 'Display header text' do
      expect(page).to have_content('Create a Post')
    end

    it 'Whether form is rendered' do
      expect(page).to have_selector('form')
    end

    it 'Display button to submit the post' do
      expect(page).to have_button('Save Post')
    end

    it 'fill the form and submit it' do
      fill_in 'Title', with: 'Test Post Title'
      fill_in 'Text', with: 'This is the content of the test post.'

      click_button 'Save Post'

      expect(page).to have_current_path(%r{/users/\d+/posts/\d+})

      expect(page).to have_content('Post was successfully created.')
    end
  end
end
