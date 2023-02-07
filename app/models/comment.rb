class Comment < ApplicationRecord
  belongs_to :author, class_name: 'Member'
  belongs_to :post
  validates :text, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }

  after_save :update_comments_counter
  after_destroy :update_comments_counter

  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_to 'comments', partial: 'posts/comment', locals: { comment: self }, target: 'comments' }

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
