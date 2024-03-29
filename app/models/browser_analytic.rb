class BrowserAnalytic < ApplicationRecord
  belongs_to :member
  belongs_to :visitor

  broadcasts_to lambda { |browser_analytic|
                  [browser_analytic.member_id, 'browser_analytics']
                }, inserts_by: :prepend, partial: 'analytics/browser_analytics'
end
