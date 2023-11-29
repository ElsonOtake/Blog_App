class CounterAnalytic < ApplicationRecord
  belongs_to :member

  broadcasts_to lambda { |counter_analytic|
                  [counter_analytic.member_id, 'counter_analytics']
                }, inserts_by: :prepend, partial: 'analytics/counter_analytics'
end
