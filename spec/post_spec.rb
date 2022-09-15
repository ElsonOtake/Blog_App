require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Anyone')
  post = Post.new(title: 'Anything', author: user)
  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end
  it 'Title must not be blank' do
    post.title = ' '
    expect(post).to_not be_valid
  end
  it 'Title must not exceed 250 characters' do
    post.title = 'a' * 251
    expect(post).to_not be_valid
  end
  it 'CommentsCounter must be an integer greater than or equal to zero' do
    expect(post.comments_counter).to be_an(Numeric)
    expect(post.comments_counter).to be >= 0
  end
  it 'LikesCounter must be an integer greater than or equal to zero' do
    expect(post.likes_counter).to be_an(Numeric)
    expect(post.likes_counter).to be >= 0
  end
  it 'Author id must be the user id' do
    expect(post.author_id).to be(user.id)
  end
  it 'Recent comments must be empty array' do
    expect(post.recent_comments.size).to be(0)
  end
end
