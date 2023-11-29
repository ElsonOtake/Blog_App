class Member < ApplicationRecord
  # :confirmable removed from the list on the deployed version
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :counter_analytics
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

  def should_generate_new_friendly_id?
    name_changed?
  end

  def self.from_omniauth(access_token)
    member = Member.where(email: access_token.info.email).first

    member ||= Member.create(name: access_token.info.name,
                             email: access_token.info.email,
                             password: Devise.friendly_token[0, 20])

    if !member.avatar.attached? && !access_token.info.image.empty?
      filename = File.basename(URI.parse(access_token.info.image).path)
      downloaded_image = URI.parse(access_token.info.image).open
      member.avatar.attach(io: downloaded_image, filename:)
      member.save!
    end
    member
  end
end
