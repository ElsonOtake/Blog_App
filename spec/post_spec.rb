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
  it 'Author_id must be the user.id' do
    expect(post.author_id).to be(user.id)
  end
  it 'Recent comments must be empty array' do
    expect(post.recent_comments.size).to be(0)
  end
  it 'Recent posts must not be empty array' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    Comment.create(text: 'Something 1', author: new_user, post: new_post)
    expect(new_post.recent_comments.size).to be(1)
  end
  it 'Recent posts must must have the recent posts' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    Comment.create(text: 'Something 1', author: new_user, post: new_post)
    Comment.create(text: 'Something 2', author: new_user, post: new_post)
    Comment.create(text: 'Something 3', author: new_user, post: new_post)
    Comment.create(text: 'Something 4', author: new_user, post: new_post)
    Comment.create(text: 'Something 5', author: new_user, post: new_post)
    Comment.create(text: 'Something 6', author: new_user, post: new_post)
    expect(new_post.recent_comments.size).to be(5)
    expect(new_post.recent_comments[0].text).to eql('Something 6')
    expect(new_post.recent_comments[1].text).to eql('Something 5')
    expect(new_post.recent_comments[2].text).to eql('Something 4')
    expect(new_post.recent_comments[3].text).to eql('Something 3')
    expect(new_post.recent_comments[4].text).to eql('Something 2')
  end
  it 'Post counter must have value 1' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    new_post.update_user_counter
    expect(new_user.post_counter).to be(1)
  end
  it 'Post counter must have value 2' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something else', author: new_user)
    new_post = Post.create(title: 'New Something else', author: new_user)
    new_post.update_user_counter
    expect(new_user.post_counter).to be(2)
  end
end
