class MemberBrowser
  require 'browser'

  def initialize(agent)
    @browser = Browser.new(agent, accept_language: 'en-us')
  end

  def platform
    @browser.platform.name
  end

  def device
    if @browser.device.mobile?
      :mobile
    elsif @browser.device.tablet?
      :tablet
    elsif @browser.device.console?
      :console
    elsif @browser.bot?
      :bot
    elsif %i[chrome_os linux mac windows].include? @browser.platform.id
      :desktop
    else
      :other
    end
  end
end
