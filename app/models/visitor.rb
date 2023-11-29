class Visitor < ApplicationRecord
  belongs_to :member, optional: true
end