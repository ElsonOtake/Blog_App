require 'rails_helper'

RSpec.describe MemberBrowser, type: :model do
  it 'platform must be unknown and device must be :bot for empty user agent' do
    agent = ''
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Unknown')
    expect(@browser.device).to be(:bot)
  end

  it 'platform must be android and device must be :tablet' do
    agent = 'Mozilla/5.0 (Linux; U; Android 4.0.3; en-us; KFTT Build/IML74K) AppleWebKit/537.36 ' \
            '(KHTML, like Gecko) Silk/3.68 like Chrome/39.0.2171.93 Safari/537.36'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Android')
    expect(@browser.device).to be(:tablet)
  end

  it 'platform must be android and device must be :mobile' do
    agent = 'Mozilla/5.0 (Linux; Android 5.0; SM-G900V Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) ' \
            'Chrome/45.0.2454.84 Mobile Safari/537.36'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Android')
    expect(@browser.device).to be(:mobile)
  end

  it 'platform must be Chrome OS and device must be :desktop' do
    agent = 'Mozilla/5.0 (X11; CrOS x86_64 7077.134.0) AppleWebKit/537.36 (KHTML, like Gecko) ' \
            'Chrome/44.0.2403.156 Safari/537.36'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Chrome OS')
    expect(@browser.device).to be(:desktop)
  end

  it 'platform must be Firefox OS and device must be :other' do
    agent = 'Mozilla/5.0 (X11; OpenBSD amd64; rv:28.0) Gecko/20100101 Firefox/28.0'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Firefox OS')
    expect(@browser.device).to be(:other)
  end

  it 'platform must be iOS (iPad) and device must be :tablet' do
    agent = 'Mozilla/5.0 (iPad; CPU OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) ' \
            'Version/8.0 Mobile/12H321 Safari/600.1.4'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('iOS (iPad)')
    expect(@browser.device).to be(:tablet)
  end

  it 'platform must be iOS (iPhone) and device must be :mobile' do
    agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) ' \
            'Version/8.0 Mobile/12H321 Safari/600.1.4'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('iOS (iPhone)')
    expect(@browser.device).to be(:mobile)
  end

  it 'platform must be iOS (iPod) and device must be :mobile' do
    agent = 'Mozilla/5.0 (iPod touch; CPU iPhone OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) ' \
            'Version/8.0 Mobile/12H321 Safari/600.1.4'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('iOS (iPod)')
    expect(@browser.device).to be(:mobile)
  end

  it 'platform must be linux and device must be :desktop' do
    agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
            'Ubuntu Chromium/37.0.2062.94 Chrome/37.0.2062.94 Safari/537.36'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Generic Linux')
    expect(@browser.device).to be(:desktop)
  end

  it 'platform must be linux and device must be :bot' do
    agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko; Google Web Preview) ' \
            'Chrome/27.0.1453 Safari/537.36'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Generic Linux')
    expect(@browser.device).to be(:bot)
  end

  it 'platform must be Mac OS X and device must be :desktop' do
    agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) ' \
            'Version/8.0.8 Safari/600.8.9'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Mac OS X')
    expect(@browser.device).to be(:desktop)
  end

  it 'platform must be Unknown and device must be :console' do
    agent = 'Mozilla/5.0 (PlayStation 4 2.57) AppleWebKit/537.73 (KHTML, like Gecko)'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Unknown')
    expect(@browser.device).to be(:console)
  end

  it 'platform must be Unknown and device must be :other' do
    agent = 'Mozilla/5.0 AppleWebKit/999.0 (KHTML, like Gecko) Chrome/99.0 Safari/999.0'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Unknown')
    expect(@browser.device).to be(:other)
  end

  it 'platform must be windows and device must be :desktop' do
    agent = 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Windows')
    expect(@browser.device).to be(:desktop)
  end

  it 'platform must be windows and device must be :tablet' do
    agent = 'Mozilla/5.0 (Windows NT 6.3; ARM; Trident/7.0; Touch; rv:11.0) like Gecko'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Windows')
    expect(@browser.device).to be(:tablet)
  end

  it 'platform must be windows and device must be :bot' do
    agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534+ (KHTML, like Gecko) MsnBot-Media /1.0b'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Windows')
    expect(@browser.device).to be(:bot)
  end

  it 'platform must be windows phone and device must be :mobile' do
    agent = 'Mozilla/5.0 (Windows Phone 8.1; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 635) ' \
            'like Gecko'
    @browser = MemberBrowser.new(agent)
    expect(@browser.platform).to eq('Windows Phone')
    expect(@browser.device).to be(:mobile)
  end
end
