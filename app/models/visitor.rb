class Visitor < ApplicationRecord
  belongs_to :member, optional: true
  has_many :counter_analytic, dependent: :destroy
  has_many :browser_analytics, dependent: :destroy
  has_many :unique_analytics, dependent: :destroy
end
