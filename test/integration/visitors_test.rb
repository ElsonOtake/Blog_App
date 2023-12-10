require 'test_helper'

class VisitorsIntegrationTest < ActionDispatch::IntegrationTest

  test 'should not create Visitor when visiting the root path' do
    assert_difference('Visitor.count', 0) do
      get root_url
    end
  end

  test 'should reuse the visitor during the session' do
    get root_url
    assert_difference('Visitor.count', 0) do
      get analytics_url
    end
  end

  test 'should record the signed in member' do
    sign_in members(:regular)
    get root_url
    assert_equal Visitor.last.reload.member, members(:regular)
  end
end
