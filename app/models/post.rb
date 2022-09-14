class Post < ApplicationRecord
  validates :title, :text
  belongs_to :user
end
