class AnalyticsController < ApplicationController
  def index
    @start_date = params[:start_date] || (Date.today - 6.days).to_s
    @end_date = params[:end_date] || Date.today.to_s
    @counter_analytics = current_user.counter_analytics.order(created_at: :desc)
    @data = []
    @counter_analytics.each do |count|
      @data << { name: count.action, data: { count.created_at.to_s => count.count } }
    end
  end
end
