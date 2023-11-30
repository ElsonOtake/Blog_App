require "test_helper"

class UniqueAnalyticTest < ActiveSupport::TestCase
  setup do
    @member = Member.first
    @visitor = Visitor.last
  end

  test "should have fixture data size" do
    assert_equal UniqueAnalytic.count, 40
  end

  test "should save unique analytic with all data" do
    unique_analytic = UniqueAnalytic.new(member: @member, visitor: @visitor)
    assert unique_analytic.save, "Saved unique analytic with member, and visitor"
  end

  test "should not save unique analytic without member" do
    unique_analytic = UniqueAnalytic.new(visitor: @visitor)
    assert_not unique_analytic.save, "Saved unique analytic without member"
  end

  test "should not save unique analytic without visitor" do
    unique_analytic = UniqueAnalytic.new(member: @member)
    assert_not unique_analytic.save, "Saved unique analytic without visitor"
  end
end
