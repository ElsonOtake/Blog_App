require 'rails_helper'

RSpec.describe 'user index view', type: :feature do
  describe 'GET index for Lilly' do
    before(:each) do
      @lilly = User.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                           bio: 'Teacher from Poland')
      Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
    end

    it 'Show the user index view path' do
      visit root_path
      expect(page).to have_xpath('/')
    end

    it 'Show username of each user' do
      visit root_path
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'Shows the uses profile picture' do
      visit root_path
      expect(page).to have_css('img[src*="meditation-dog"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it 'Shows the number of posts of each user' do
      visit root_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 1')
    end

    it "click on name 'Lilly' to redirect to user's show page" do
      visit root_path
      click_link 'Lilly'
      expect(current_path).to eq user_path(@lilly)
    end
  end

  describe 'GET index' do
    before(:each) do
      @luna = User.create(name: 'Luna', photo: 'https://c.tenor.com/JAWsyDUCa4QAAAAM/puppy-stretching.gif',
                          bio: 'Teacher from Brazil')
      Post.create(author: @luna, title: 'Hi', text: 'This is my first post')
    end

    it 'Show the user index view path' do
      visit root_path
      expect(page).to have_xpath('/')
    end

    it 'Show username of each user' do
      visit root_path
      expect(page).to have_content('Luna')
      expect(page).to_not have_content('Lilly')
    end

    it 'Shows the uses profile picture' do
      visit root_path
      expect(page).to have_css('img[src*="puppy-stretching"]')
      expect(page).to_not have_css('img[src*="meditation-dog"]')
    end

    it 'Shows the number of posts of each user' do
      visit root_path
      expect(page).to have_content('Number of posts: 1')
      expect(page).to_not have_content('Number of posts: 2')
    end

    it "click on name 'Luna' to redirect to user's show page" do
      visit root_path
      click_link 'Luna'
      expect(current_path).to eq user_path(@luna)
    end
  end
end
