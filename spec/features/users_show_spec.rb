require 'rails_helper'

RSpec.describe 'The show user page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Lilly', photo: 'https://c.tenor.com/YIeHLcvImMsAAAAM/meditation-dog.gif',
                        bio: 'Teacher from Poland')
    # @user.save!
    @post_one = Post.create(title: 'First post', text: 'Hello world!', author: @user)
    @post_two = Post.create(title: 'Second post', text: 'Quantum Mechanics!', author: @user)

    # visit(user_path(id: @user))
  end

  it 'show profile pictures for the user' do
    expect(page).to have_css('img[src*="img_1.png"]')
  end

  it 'shows username of the user' do
    expect(page).to have_content('Lilly')
  end

  it 'shows the number of posts for the user' do
    expect(page).to have_content('Number of posts: 2')
  end

  it "click on See all posts to redirect to user's post's index page" do
    click_link 'See all posts'
    expect(current_path).to eq user_posts_path(@user)
  end
end
