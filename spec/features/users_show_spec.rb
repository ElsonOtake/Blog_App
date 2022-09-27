require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  describe 'Show page for Lilly' do
    before(:each) do
      @lilly = User.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                           bio: 'Teacher from Poland')
      @hello = Post.create(author: @lilly, title: 'Hello', text: 'This is my first post')
      Post.create(author: @lilly, title: 'Hey', text: 'This is my second post')
    end

    it "Shows the user's profile picture" do
      visit user_path(@lilly)
      expect(page).to have_css('img[src*="meditation-dog"]')
      expect(page).to_not have_css('img[src*="puppy-stretching"]')
    end

    it "Show the user's username" do
      visit user_path(@lilly)
      expect(page).to have_content('Lilly')
      expect(page).to_not have_content('Luna')
    end

    it 'Shows the number of posts the user has written' do
      visit user_path(@lilly)
      expect(page).to have_content('Number of posts: 2')
      expect(page).to_not have_content('Number of posts: 0')
    end

    it "Show the user's bio" do
      visit user_path(@lilly)
      expect(page).to have_content('Teacher from Poland')
      expect(page).to_not have_content('Teacher from Brazil')
    end

    it "Show the user's first 3 posts" do
      visit user_path(@lilly)
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to_not have_content("This is Luna's first post")
      expect(page).to have_content('Hello')
      expect(page).to have_content('Hey')
      expect(page).to_not have_content('Hi')
    end

    it "I can see a button that lets me view all of a user's posts" do
      visit user_path(@lilly)
      expect(page).to have_content('See all posts')
    end

    it "When I click a user's post, it redirects me to that post's show page" do
      visit user_path(@lilly)
      click_link 'Hello'
      expect(current_path).to eq user_post_path(@lilly, @hello)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      visit user_path(@lilly)
      click_link 'See all posts'
      expect(current_path).to eq user_posts_path(@lilly)
    end
  end

  describe 'Show page for Luna' do
    before(:each) do
      @luna = User.create(name: 'Luna', photo: 'https://c.tenor.com/JAWsyDUCa4QAAAAM/puppy-stretching.gif',
                          bio: 'Teacher from Brazil')
      Post.create(author: @luna, title: 'Hi one', text: "This is Luna's first post")
      Post.create(author: @luna, title: 'Hi two', text: "This is Luna's second post")
      @hi_three = Post.create(author: @luna, title: 'Hi three', text: "This is Luna's third post")
      Post.create(author: @luna, title: 'Hi four', text: "This is Luna's fourth post")
      Post.create(author: @luna, title: 'Hi five', text: "This is Luna's fifth post")
    end

    it "Shows the user's profile picture" do
      visit user_path(@luna)
      expect(page).to have_css('img[src*="puppy-stretching"]')
      expect(page).to_not have_css('img[src*="meditation-dog"]')
    end

    it "Show the user's username" do
      visit user_path(@luna)
      expect(page).to have_content('Luna')
      expect(page).to_not have_content('Lilly')
    end

    it 'Shows the number of posts the user has written' do
      visit user_path(@luna)
      expect(page).to have_content('Number of posts: 5')
      expect(page).to_not have_content('Number of posts: 0')
    end

    it "Show the user's bio" do
      visit user_path(@luna)
      expect(page).to have_content('Teacher from Brazil')
      expect(page).to_not have_content('Teacher from Poland')
    end

    it "Show the user's first 3 posts" do
      visit user_path(@luna)
      expect(page).to have_content("This is Luna's fifth post")
      expect(page).to have_content("This is Luna's fourth post")
      expect(page).to have_content("This is Luna's third post")
      expect(page).to_not have_content("This is Luna's second post")
      expect(page).to_not have_content("This is Luna's first post")
      expect(page).to have_content('Hi five')
      expect(page).to have_content('Hi four')
      expect(page).to have_content('Hi three')
      expect(page).to_not have_content('Hi two')
      expect(page).to_not have_content('Hi one')
    end

    it "I can see a button that lets me view all of a user's posts" do
      visit user_path(@luna)
      expect(page).to have_content('See all posts')
    end

    it "When I click a user's post, it redirects me to that post's show page" do
      visit user_path(@luna)
      click_link 'Hi three'
      expect(current_path).to eq user_post_path(@luna, @hi_three)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      visit user_path(@luna)
      click_link 'See all posts'
      expect(current_path).to eq user_posts_path(@luna)
    end
  end
end
