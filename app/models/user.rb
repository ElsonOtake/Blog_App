class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  validates :name, presence: true

  def recent_posts
    posts.order(created_at: :desc).first(3)
  end
end
