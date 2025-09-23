class AnalyticsController < ApplicationController
  before_action :authenticate_member!

  def index
    # Use Time.current for timezone-aware dates
    today = Time.current.to_date
    @start_date = params[:start_date] || (today - 6.days).to_s
    @end_date = params[:end_date] || today.to_s

    # Convert string dates to timezone-aware datetime objects
    start_datetime = Time.zone.parse(@start_date).beginning_of_day
    end_datetime = Time.zone.parse(@end_date).end_of_day

    %w[counter_analytics length_analytics unique_analytics browser_analytics].each do |analytics|
      instance_variable_set("@#{analytics}", current_user
                                      .send(analytics)
                                      .where(created_at: start_datetime..end_datetime)
                                      .order(created_at: :desc))
    end
  end
end
