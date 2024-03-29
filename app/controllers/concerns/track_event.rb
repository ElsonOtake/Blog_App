module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    AddCounterJob.perform_later(session[:action], session[:post_author], current_visitor.id)
    AddLengthJob.perform_later(session[:post_author], session[:comment_length]) if session[:action] == 'create'
    AddBrowserJob.perform_later(session[:post_author], current_visitor.id, current_visitor.user_agent)
    AddUniqueJob.perform_later(session[:post_author], current_visitor.id)
  end
end
