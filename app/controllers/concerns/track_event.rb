module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    puts "********** request.path #{request.path}"
    path = Rails.application.routes.recognize_path(request.path)

    controller = path[:controller]
    action = path[:action]
    puts "********** controller #{controller}"
    puts "********** action #{action}"
  end
end