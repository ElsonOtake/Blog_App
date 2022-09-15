require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Anyone')
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end
  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'Name must not be blank' do
    user.name = ' '
    expect(user).to_not be_valid
  end
  it 'PostsCounter must be an integer greater than or equal to zero' do
    expect(user.post_counter).to be_an(Numeric)
    expect(user.post_counter).to be >= 0
  end
  it 'Recent posts must be empty array' do
    expect(user.recent_posts.size).to be(0)
  end
  it 'Recent posts must not be empty array' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    expect(new_user.recent_posts.size).to be(1)
  end
  it 'Recent posts must have title Something 1' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    expect(new_user.recent_posts[0].title).to eql('Something 1')
  end
  it 'Recent posts must have size 2' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    Post.create(title: 'Something 2', author: new_user)
    expect(new_user.recent_posts.size).to be(2)
  end
  it 'Recent posts must have size 3' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    Post.create(title: 'Something 2', author: new_user)
    Post.create(title: 'Something 3', author: new_user)
    expect(new_user.recent_posts.size).to be(3)
  end
  it 'Recent posts must must have size 3' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    Post.create(title: 'Something 2', author: new_user)
    Post.create(title: 'Something 3', author: new_user)
    Post.create(title: 'Something 4', author: new_user)
    expect(new_user.recent_posts.size).to be(3)
  end
  it 'Recent posts must must have the recent posts' do
    new_user = User.create(name: 'Anyone else')
    Post.create(title: 'Something 1', author: new_user)
    Post.create(title: 'Something 2', author: new_user)
    Post.create(title: 'Something 3', author: new_user)
    Post.create(title: 'Something 4', author: new_user)
    expect(new_user.recent_posts[0].title).to eql('Something 4')
    expect(new_user.recent_posts[1].title).to eql('Something 3')
    expect(new_user.recent_posts[2].title).to eql('Something 2')
  end
end
