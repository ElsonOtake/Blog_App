module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    CreateCounterJob.perform_async(session[:action], session[:post_author])
    # counter = CounterAnalytic.where(action: session[:action], member_id: session[:post_author]).first_or_create!
    # counter.count += 1
    # counter.save!
    CreateBrowserJob.perform_async(session[:post_author], current_visitor.id, current_visitor.user_agent)
    CreateUniqueJob.perform_async(session[:post_author], current_visitor.id)
  end
end
