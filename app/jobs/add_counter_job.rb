class AddCounterJob < ApplicationJob
  queue_as :default

  def perform(action, member, visitor)
    event = CounterAnalytic.where(action:, member_id: member, visitor_id: visitor).first_or_create!
    event.count += 1
    event.save!
  end
end
