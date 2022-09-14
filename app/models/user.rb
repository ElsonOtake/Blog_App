class User < ApplicationRecord
  validates :name, :photo, :bio
end
