module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    event = CounterAnalytic.where(action: flash[:action] , member: current_user).first_or_create!
    event.count += 1
    event.save!
  end
end