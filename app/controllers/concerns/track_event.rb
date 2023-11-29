module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    # CreateCounterJob.perform_async(session[:action], session[:post_author])
    event = CounterAnalytic.where(action: session[:action], member_id: session[:post_author]).first_or_create!
    event.count += 1
    event.save!
  end
end
