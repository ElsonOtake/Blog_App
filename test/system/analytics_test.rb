require 'application_system_test_case'

class AnalyticsTest < ApplicationSystemTestCase
  setup do
    sign_in members(:regular)
  end

  test 'should show analytics page with user logged in' do
    visit analytics_url
    assert_text 'Comment analytics'
    assert_text 'Comments'
    assert_text 'Average comment length'
    assert_text 'Unique visitors'
    assert_text 'Browser device'
    assert_text 'Browser platform'
    sleep 10
    click_on 'Back'
    click_on 'Sign out'
  end

  test 'should show login page without user logged in' do
    sign_out :member
    visit analytics_url
    assert_text 'Log in'
  end
end
