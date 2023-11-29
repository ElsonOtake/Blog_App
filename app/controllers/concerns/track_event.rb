module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    # puts "************************** size #{session[:comment_size]}"
    CreateCounterJob.perform_async(session[:action], session[:post_author])
  end
end
