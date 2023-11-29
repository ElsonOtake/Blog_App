class AnalyticsController < ApplicationController
  def index
    @data = []
    @counter_analytics = current_user.counter_analytics.order(created_at: :desc)
    @counter_analytics.each do |count|
      @data << { name: count.action, data: { count.created_at.to_s => count.count } }
    end
  end
end
