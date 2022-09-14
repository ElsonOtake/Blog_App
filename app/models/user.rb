class User < ApplicationRecord
  validates :name, :photo, :bio
  has_many :comments
  has_many :likes
  has_many :posts
end
