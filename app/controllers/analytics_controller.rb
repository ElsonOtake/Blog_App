class AnalyticsController < ApplicationController
  def index
    @start_date = params[:start_date] || (Date.today - 6.days).to_s
    @end_date = params[:end_date] || Date.today.to_s
    @counter_analytics = current_user
      .counter_analytics
      .where("created_at BETWEEN ? AND ?", @start_date + ' 00:00:00', @end_date + ' 23:59:59')
      .order(created_at: :desc)
    @length_analytics = current_user
      .length_analytics
      .where("created_at BETWEEN ? AND ?", @start_date + ' 00:00:00', @end_date + ' 23:59:59')
      .order(created_at: :desc)
    @unique_analytics = current_user
      .unique_analytics
      .where("created_at BETWEEN ? AND ?", @start_date + ' 00:00:00', @end_date + ' 23:59:59')
      .order(created_at: :desc)
    @browser_analytics = current_user
      .browser_analytics
      .where("created_at BETWEEN ? AND ?", @start_date + ' 00:00:00', @end_date + ' 23:59:59')
      .order(created_at: :desc)
  end
end
