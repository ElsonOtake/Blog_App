require 'test_helper'

class AnalyticsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index if user signed in' do
    sign_in members(:regular)
    get analytics_url
    assert_response :success
  end

  test 'should not get index without user signed in' do
    get analytics_url
    assert_response :redirect
  end
end
