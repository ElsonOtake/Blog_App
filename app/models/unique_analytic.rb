class UniqueAnalytic < ApplicationRecord
  belongs_to :member
  belongs_to :visitor

  broadcasts_to lambda { |unique_analytic|
                  [unique_analytic.member_id, 'unique_analytics']
                }, inserts_by: :prepend, partial: 'analytics/unique_analytics'
end
