module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    CreateCounterJob.perform_async(flash[:action], current_user.id)
  end
end