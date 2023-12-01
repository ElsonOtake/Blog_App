class CreateCounterJob
  include Sidekiq::Job

  def perform(action, member, visitor)
    event = CounterAnalytic.where(action: action, member_id: member, visitor_id: visitor).first_or_create!
    event.count += 1
    event.save!
  end
end
