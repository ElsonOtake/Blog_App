require 'rails_helper'
require_relative '../config/environment'

RSpec.describe 'The show user page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 2)
    @user.save!
    @post_one = Post.create(title: 'First post', text: 'Hello world!', id: 1, comments_counter: 0, likes_counter: 0)
    @post_two = Post.create(title: 'Second post', text: 'Quantum Mechanics!', id: 2, comments_counter: 0,
                            likes_counter: 0)

    visit(user_path(id: @user))
  end

  it 'show profile pictures fo the user' do
    expect(page).to have_css('img[src*="img_1.png"]')
  end

  it 'shows username of the user' do
    expect(page).to have_content('Addisu')
  end

  it 'shows the number of posts for the user' do
    expect(page).to have_content('Number of posts: 2')
  end

  it "click on See all posts to redirect to user's post's index page" do
    click_link 'See all posts'
    expect(current_path).to eq user_posts_path(@user)
  end
end
