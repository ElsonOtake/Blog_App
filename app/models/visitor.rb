class Visitor < ApplicationRecord
  belongs_to :member, optional: true
  has_many :counter_analytic
  has_many :browser_analytics
  has_many :unique_analytics
end
