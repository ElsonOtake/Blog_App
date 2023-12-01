module TrackEvent
  extend ActiveSupport::Concern

  def track_event
    CreateCounterJob.perform_async(session[:action], session[:post_author], current_visitor.id)
    CreateLengthJob.perform_async(session[:post_author], session[:comment_length]) if session[:action] == 'create'
    CreateBrowserJob.perform_async(session[:post_author], current_visitor.id, current_visitor.user_agent)
    CreateUniqueJob.perform_async(session[:post_author], current_visitor.id)
    # create_counter(session[:action], session[:post_author])
    # create_length(session[:post_author], session[:comment_length]) if session[:action] == 'create'
    # create_browser(session[:post_author], current_visitor.id, current_visitor.user_agent)
    # create_unique(session[:post_author], current_visitor.id)
  end

  def create_counter(action, member, visitor)
    counter = CounterAnalytic.where(action:, member_id: member, visitor_id: visitor).first_or_create!
    counter.count += 1
    counter.save!
  end

  def create_length(member, length)
    LengthAnalytic.create!(member_id: member, comment_length: length)
  end

  def create_browser(member, visitor, agent)
    browser = Browser.new(agent, accept_language: 'en-us')
    device = device_type(browser)
    platform = browser.platform.name
    BrowserAnalytic.where(member_id: member,
                          visitor_id: visitor,
                          device:,
                          platform:).first_or_create!
  end

  def device_type(browser)
    if browser.device.mobile?
      :mobile
    elsif browser.device.tablet?
      :tablet
    elsif browser.device.console?
      :console
    elsif browser.bot?
      :bot
    elsif %i[chrome_os linux mac windows].any? { |computer| computer == browser.platform.id }
      :desktop
    else
      :other
    end
  end

  def create_unique(member, visitor)
    UniqueAnalytic.where(member_id: member,
                         visitor_id: visitor).first_or_create!
  end
end
