require "test_helper"

class CounterAnalyticTest < ActiveSupport::TestCase
  setup do
    @member = Member.first
    @visitor = Visitor.first
  end

  test "should assert the fixture data size" do
    assert_equal CounterAnalytic.count, 40
  end

  test "should save counter analytic without count" do
    counter_analytic = CounterAnalytic.new(action: "MyString", member: @member)
    assert counter_analytic.save, "Saved counter analytic with action and member"
  end

  test "should not save counter analytic without member" do
    counter_analytic = CounterAnalytic.new(action: "MyString")
    assert_not counter_analytic.save, "Saved counter analytic without member"
  end

  test "should add number to count" do
    counter_analytic = CounterAnalytic.new(action: "MyString", member: @member)
    assert counter_analytic.save, "Saved counter analytic with action and member"
    assert_equal counter_analytic.count, 0
    counter_analytic.count += 1
    assert counter_analytic.save, "Saved counter analytic with new count value"
    assert_equal counter_analytic.count, 1
  end
end
