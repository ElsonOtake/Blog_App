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
  it 'Recent posts must be empty array' do
    Post.new(title: 'Anything', author: user)
    Post.new(title: 'Other thing', author: user)
    expect(user.recent_posts.size).to be(0)
  end
end
