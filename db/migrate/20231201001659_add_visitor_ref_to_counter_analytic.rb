class AddVisitorRefToCounterAnalytic < ActiveRecord::Migration[7.0]
  def change
    add_reference :counter_analytics, :visitor, foreign_key: true
  end
end
