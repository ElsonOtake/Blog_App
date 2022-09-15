require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Anyone')
  post = Post.new(title: 'Anything', author: user)
  comment = Comment.new(text: 'Something', author: user, post:)
  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end
  it 'is not valid without valid attributes' do
    comment_without_user = Comment.new(text: 'Something', post:)
    expect(comment_without_user).to_not be_valid
  end
  it 'is not valid without valid attributes' do
    comment_without_post = Comment.new(text: 'Something', author: user)
    expect(comment_without_post).to_not be_valid
  end
  it 'Text must not be blank' do
    comment.text = ' '
    expect(comment).to_not be_valid
  end
  it 'Text must not exceed 250 characters' do
    comment.text = 'b' * 251
    expect(comment).to_not be_valid
  end
  it 'Author_id must be the user.id' do
    expect(comment.author_id).to be(user.id)
  end
  it 'Post_id must be the post.id' do
    expect(comment.post_id).to be(post.id)
  end
  it 'Post counter must have value 1' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    new_comment = Comment.create(text: 'Something 1', author: new_user, post: new_post)
    new_comment.update_comments_counter
    expect(new_post.comments_counter).to be(1)
  end
  it 'Post counter must have value 6' do
    new_user = User.create(name: 'Anyone else')
    new_post = Post.create(title: 'Something else', author: new_user)
    Comment.create(text: 'Something 1', author: new_user, post: new_post)
    Comment.create(text: 'Something 2', author: new_user, post: new_post)
    Comment.create(text: 'Something 3', author: new_user, post: new_post)
    Comment.create(text: 'Something 4', author: new_user, post: new_post)
    Comment.create(text: 'Something 5', author: new_user, post: new_post)
    new_comment = Comment.create(text: 'Something 6', author: new_user, post: new_post)
    new_comment.update_comments_counter
    expect(new_post.comments_counter).to be(6)
  end
end
