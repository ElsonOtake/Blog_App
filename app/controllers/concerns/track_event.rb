module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    # CreateCounterJob.perform_async(session[:action], session[:post_author], current_visitor.id)
    # CreateLengthJob.perform_async(session[:post_author], session[:comment_length]) if session[:action] == 'create'
    # CreateBrowserJob.perform_async(session[:post_author], current_visitor.id, current_visitor.user_agent)
    # CreateUniqueJob.perform_async(session[:post_author], current_visitor.id)

    AddCounterJob.perform_later(session[:action], session[:post_author], current_visitor.id)
    AddLengthJob.perform_later(session[:post_author], session[:comment_length]) if session[:action] == 'create'
    AddBrowserJob.perform_later(session[:post_author], current_visitor.id, current_visitor.user_agent)
    AddUniqueJob.perform_later(session[:post_author], current_visitor.id)
  end
end
