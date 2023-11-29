class CreateCounterJob
  include Sidekiq::Job

  def perform(action, member)
    event = CounterAnalytic.where(action: action , member_id: member).first_or_create!
    event.count += 1
    event.save!
  end
end
