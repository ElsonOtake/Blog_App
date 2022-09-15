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
  it 'Likes counter must have value 1' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    new_like = Like.create(author: new_user, post: new_post)
    new_like.update_likes_counter
    expect(new_post.likes_counter).to be(1)
  end
  it 'Likes counter must have value 5' do
    new_user_a = User.create(name: 'Anyone else 1')
    new_user_b = User.create(name: 'Anyone else 2')
    new_user_c = User.create(name: 'Anyone else 3')
    new_user_d = User.create(name: 'Anyone else 4')
    new_user_e = User.create(name: 'Anyone else 5')
    new_post = Post.create(title: 'Something else', author: new_user_a)
    Like.create(author: new_user_a, post: new_post)
    Like.create(author: new_user_b, post: new_post)
    Like.create(author: new_user_c, post: new_post)
    Like.create(author: new_user_d, post: new_post)
    new_like = Like.create(author: new_user_e, post: new_post)
    new_like.update_likes_counter
    expect(new_post.likes_counter).to be(5)
  end
end
