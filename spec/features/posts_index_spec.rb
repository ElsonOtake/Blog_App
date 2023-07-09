require 'rails_helper'

RSpec.describe 'Member post index page', type: :feature do
  describe 'with FactoryBot login' do
    before(:each) do
      @member = FactoryBot.create(:member)
      @lilly = Member.create(name: 'Lilly', bio: 'Teacher from Poland', email: 'lilly@blog.com',
                             password: 'password', confirmed_at: Time.now)
      @tom = Member.create(name: 'Tom', bio: 'Teacher from Mexico.', email: 'tom@blog.com',
                           password: 'password', confirmed_at: Time.now)
      @jim = Member.create(name: 'Jim', bio: 'Teacher from Japan.', email: 'jim@blog.com',
                           password: 'password', confirmed_at: Time.now)
      @bill = Member.create(name: 'Bill', bio: 'Teacher from Uganda.', email: 'bill@blog.com',
                            password: 'password', confirmed_at: Time.now)
      @hello = @lilly.posts.create(title: 'Hello', text: 'This is my first post')
      # @hello = Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      # Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
      @lilly.posts.create(title: 'Hey', text: 'This is my second post')
      @hello.comments.create(author: @tom, text: 'First comment')
      @hello.comments.create(author: @lilly, text: 'Second comment')
      @hello.comments.create(author: @jim, text: 'Third comment')
      @hello.comments.create(author: @bill, text: 'Fourth comment')
      @hello.comments.create(author: @tom, text: 'Fifth comment')
      # Comment.create(post: @hello, author: @tom, text: 'First comment')
      # Comment.create(post: @hello, author: @lilly, text: 'Second comment')
      # Comment.create(post: @hello, author: @jim, text: 'Third comment')
      # Comment.create(post: @hello, author: @bill, text: 'Fourth comment')
      # Comment.create(post: @hello, author: @tom, text: 'Fifth comment')
      # Like.create(post: @hello, author: @bill)
      # Like.create(post: @hello, author: @jim)
      # Like.create(post: @hello, author: @tom)
      @hello.likes.create(author: @bill)
      @hello.likes.create(author: @jim)
      @hello.likes.create(author: @tom)
      sign_in @member
      visit member_posts_path(@lilly)
    end

    it "shows Lilly's post page" do
      expect(page).to have_current_path("/members/#{@lilly.name.parameterize}/posts")
    end

    it 'shows the default profile picture' do
      expect(page).to have_css('img[src*="profile-picture"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it "shows the member's username" do
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'shows posts title' do
      expect(page).to have_content('Hello')
      expect(page).to have_content('Hey')
      expect(page).to_not have_content('Hi')
    end

    it "shows post's body" do
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to_not have_content('This is my third post')
    end

    it 'shows comments' do
      expect(page).to have_content('First comment')
    end

    it 'shows how many comments a post has' do
      expect(page).to have_content('5')
    end

    it 'shows how many likes a post has' do
      expect(page).to have_content('3')
    end

    it 'shows the username of each commentor' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
      expect(page).to have_content('Bill')
      expect(page).to have_content('Jim')
    end

    it 'shows the comment each commentor left' do
      expect(page).to have_content('First comment')
      expect(page).to have_content('Second comment')
      expect(page).to have_content('Third comment')
      expect(page).to have_content('Fourth comment')
      expect(page).to have_content('Fifth comment')
    end

    it 'will have links' do
      expect(page).to have_link('API endpoints')
      expect(page).to have_link('Sign out')
      expect(page).to have_link('Edit profile')
      expect(page).to have_link('Add post')
    end
  end
end
