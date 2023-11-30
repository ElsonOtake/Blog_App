class LengthAnalytic < ApplicationRecord
  belongs_to :member

  broadcasts_to lambda { |length_analytic|
                  [length_analytic.member_id, 'length_analytics']
                }, inserts_by: :prepend, partial: 'analytics/length_analytics'
end
