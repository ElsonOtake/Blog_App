require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Anyone')
  post = Post.new(title: 'Anything', author: user)
  comment = Comment.new(text: 'Something', author: user, post:)
  it 'is valid with valid attributes' do
    expect(comment).to be_valid
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
end
