class Member < ApplicationRecord
  # :confirmable removed from the list on the deployed version
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: [:github]
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

  def should_generate_new_friendly_id?
    name_changed?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    member = Member.where(email: data['email']).first

    member ||= Member.create(name: data['name'],
                             email: data['email'],
                             password: Devise.friendly_token[0, 20])

    if !member.avatar.attached? && !data['image'].empty?
      filename = File.basename(url.path)
      downloaded_image = URI.parse(data['image']).open
      member.avatar.attach(io: downloaded_image, filename:)
      member.save!
    end
    member
  end
end
