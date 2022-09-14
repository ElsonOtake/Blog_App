class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  # A method that returns the 3 most recent posts for a given user
  def recent_posts
    Post.order(created_at: :desc).first(3)
  end
end
