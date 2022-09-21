class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  validates :text, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }

  after_save :update_comments_counter

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
