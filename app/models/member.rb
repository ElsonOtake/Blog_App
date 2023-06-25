class Member < ApplicationRecord
  # :confirmable removed from the list on the deployed version
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [110, 110]
  end

  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :avatar, content_type: ['image/png', 'image/jpeg'], size: {
    less_than: 1.megabytes,
    message: 'is greater than 1 megabyte'
  }

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders history]

  def is?(requested_role)
    role == requested_role.to_s
  end

  def recent_posts
    posts.order(created_at: :desc).first(3)
  end
end
