require 'rails_helper'

RSpec.describe 'Show post page: ', type: :feature do
  before(:each) do
    @user = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 0)
    @user.save!

    @post_one = Post.create(title: 'First post', text: 'Hello world!', id: 1, comments_counter: 0, likes_counter: 0)

    @comment_one = Comment.create(post: @post, user: @user, text: 'First comment')
    @comment_one.save!
    @comment_two = Comment.create(post: @post, user: @user, text: 'Second comment')

    visit "/users/#{@user.id}/posts/#{@post.id}"
  end

  it 'shows the name of the author' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the posts title' do
    expect(page).to have_content(@post.title)
  end

  it 'shows the number of comments for a post' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'shows the number of likes for a post' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end
end
