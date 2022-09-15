class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  validates :title, presence: true, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed" }

  after_save :update_user_counter

  def recent_comments
    comments.order(created_at: :desc).first(5)
  end

  def update_user_counter
    author.update(post_counter: author.posts.count)
  end
end
