module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    event = CounterAnalytic.where(action: session[:action], member_id: session[:post_author]).first_or_create!
    event.count += 1
    event.save!
  end
end
