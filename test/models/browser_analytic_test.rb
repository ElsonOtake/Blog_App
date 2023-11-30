require "test_helper"

class BrowserAnalyticTest < ActiveSupport::TestCase
  setup do
    @member = Member.first
    @visitor = Visitor.first
  end

  test "should have fixture data size" do
    assert_equal BrowserAnalytic.count, 40
  end

  test "should save browser analytic with all data" do
    browser_analytic = BrowserAnalytic.new(member: @member, visitor: @visitor, device: "MyDevice", platform: "MyPlatform")
    assert browser_analytic.save, "Saved browser analytic with name, member, and visitor"
  end

  test "should not save browser analytic without member" do
    browser_analytic = BrowserAnalytic.new(visitor: @visitor, device: "MyDevice", platform: "MyPlatform")
    assert_not browser_analytic.save, "Saved browser analytic without member"
  end

  test "should not save browser analytic without visitor" do
    browser_analytic = BrowserAnalytic.new(member: @member, device: "MyDevice", platform: "MyPlatform")
    assert_not browser_analytic.save, "Saved browser analytic without visitor"
  end
end
