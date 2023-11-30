require "test_helper"

class LengthAnalyticTest < ActiveSupport::TestCase
  setup do
    @member = Member.first
    @visitor = Visitor.first
  end

  test "should have fixture size data" do
    assert_equal LengthAnalytic.count, 20
  end

  test "should save time analytic with all data" do
    time_analytic = LengthAnalytic.new(member: @member, comment_length: 36)
    assert time_analytic.save, "Saved time analytic with member and comment length"
  end

  test "should not save time analytic without member" do
    time_analytic = LengthAnalytic.new(comment_length: 36)
    assert_not time_analytic.save, "Saved time analytic without member"
  end
end
