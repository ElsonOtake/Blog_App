require 'rails_helper'

RSpec.describe 'Member index page', type: :feature do
  describe 'with FactoryBot login' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @lilly = Member.create(name: 'Lilly', bio: 'Teacher from Poland', email: 'lilly@blog.com',
                             password: 'password', confirmed_at: Time.now)
      @lilly.posts.create(title: 'Hello', text: 'This is my first post')
      @lilly.posts.create(title: 'Hey', text: 'This is my second post')
      sign_in @member
      visit root_path
    end

    it 'shows the member index view path' do
      expect(page).to have_current_path('/')
    end

    it "shows Lilly's username" do
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'shows the default profile picture' do
      expect(page).to have_css('img[src*="profile-picture"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it "shows Lilly's email" do
      expect(page).to have_content('lilly@blog.com')
      expect(page).to_not have_content('luna@blog.com')
    end

    it "shows the member's bio" do
      expect(page).to have_content('Teacher from Poland')
      expect(page).to_not have_content('Teacher from Brazil')
    end

    it 'shows the number of posts' do
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 1')
    end

    it 'will have links' do
      expect(page).to have_link('API endpoints')
      expect(page).to have_link('Sign out')
      expect(page).to have_link('Edit profile')
      expect(page).to have_link('Show posts')
      expect(page).to have_link('Add post')
    end
  end

  describe 'with FactoryBot login' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @luna = Member.create(name: 'Luna', bio: 'Teacher from Brazil', email: 'luna@blog.com',
                            password: 'password', confirmed_at: Time.now)
      @luna.posts.create(title: 'Hi', text: 'This is my first post')
      sign_in @member
      visit root_path
    end

    it 'shows the member index view path' do
      expect(page).to have_xpath('/')
    end

    it "shows Luna's username" do
      expect(page).to have_content('Luna')
      expect(page).to_not have_content('Lilly')
    end

    it 'shows the default profile picture' do
      expect(page).to have_css('img[src*="profile-picture"]')
      expect(page).to_not have_css('img[src*="meditation-dog"]')
    end

    it "shows Luna's email" do
      expect(page).to have_content('luna@blog.com')
      expect(page).to_not have_content('lilly@blog.com')
    end

    it "shows the member's bio" do
      expect(page).to have_content('Teacher from Brazil')
      expect(page).to_not have_content('Teacher from Poland')
    end

    it 'Shows the number of posts' do
      expect(page).to have_content('Number of posts: 1')
      expect(page).to_not have_content('Number of posts: 2')
    end

    it 'will have links' do
      expect(page).to have_link('API endpoints')
      expect(page).to have_link('Sign out')
      expect(page).to have_link('Edit profile')
      expect(page).to have_link('Show posts')
      expect(page).to have_link('Add post')
    end
  end
end
