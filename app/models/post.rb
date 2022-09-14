class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  def recent_comments
    Comment.order(created_at: :desc).first(5)
  end
end
