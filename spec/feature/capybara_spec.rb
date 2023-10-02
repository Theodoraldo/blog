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
  end
end
