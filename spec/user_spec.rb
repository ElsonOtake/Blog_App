require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Name must not be blank'
  it 'PostsCounter must be an integer greater than or equal to zero'
end
