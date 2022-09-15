require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Anyone')
  post = Post.new(title: 'Anything', author: user)
  like = Like.new(author: user, post:)
  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end
  it 'is not valid without valid attributes' do
    like_without_user = Like.new(post:)
    expect(like_without_user).to_not be_valid
  end
  it 'is not valid without valid attributes' do
    like_without_post = Like.new(author: user)
    expect(like_without_post).to_not be_valid
  end
  it 'Author_id must be the user.id' do
    expect(like.author_id).to be(user.id)
  end
  it 'Post_id must be the post.id' do
    expect(like.post_id).to be(post.id)
  end
end
