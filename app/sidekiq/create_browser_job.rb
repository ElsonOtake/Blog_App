class CreateBrowserJob
  include Sidekiq::Job
  require "browser"

  def perform(member, agent)
    browser = Browser.new(agent, accept_language: "en-us")
    device = device_type(browser)
    platform = browser.platform.name
    BrowserAnalytic.where(member_id: member,
                          device: device,
                          platform: platform).first_or_create
  end
  
  def device_type(browser)
    device_type = if browser.device.mobile?
      :mobile
    elsif browser.device.tablet?
      :tablet
    elsif browser.device.console?
      :console
    elsif browser.bot?
      :bot
    elsif [:chrome_os, :linux, :mac, :windows].any? { |computer| computer == browser.platform.id }
      :desktop
    else
      :other
    end
  end
end
