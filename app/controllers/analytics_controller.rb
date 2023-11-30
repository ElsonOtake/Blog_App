class AnalyticsController < ApplicationController
  def index
    @start_date = params[:start_date] || (Date.today - 6.days).to_s
    @end_date = params[:end_date] || Date.today.to_s
    %w(counter_analytics length_analytics unique_analytics browser_analytics).each do |analytics|
      instance_variable_set("@#{analytics}", current_user
                                      .send(analytics)
                                      .where("created_at BETWEEN ? AND ?", @start_date + ' 00:00:00', @end_date + ' 23:59:59')
                                      .order(created_at: :desc))
    end
  end
end
