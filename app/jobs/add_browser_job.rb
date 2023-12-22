class AddBrowserJob < ApplicationJob
  queue_as :default

  def perform(member_id, visitor_id, agent)
    browser = MemberBrowser.new(agent)
    device = browser.device
    platform = browser.platform
    BrowserAnalytic.where(member_id:,
                          visitor_id:,
                          device:,
                          platform:).first_or_create!
  end
end
