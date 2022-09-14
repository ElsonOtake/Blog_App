class Post < ApplicationRecord
  validates :title, :text
  belongs_to :user
  has_many :comments
  has_many :likes
end
