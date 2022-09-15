require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'Title must not be blank'
  it 'Title must not exceed 250 characters'
  it 'CommentsCounter must be an integer greater than or equal to zero'
  it 'LikesCounter must be an integer greater than or equal to zero'
end
