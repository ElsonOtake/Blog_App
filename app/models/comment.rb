class Comment < ApplicationRecord
  validates :text
  belongs_to :user
  belongs_to :post
end
