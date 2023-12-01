require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  setup do
    @member = Member.first
  end

  test 'should save visitor with user_agent only' do
    visitor = Visitor.new(user_agent: 'MyString')
    assert visitor.save, 'Saved visitor with user_agent only'
  end

  test 'should save visitor with collected user_agent and logged in member' do
    visitor = Visitor.new(user_agent: 'MyString', member: @member)
    assert visitor.save, 'Saved visitor with user_agent and member_id'
  end

  test 'should include member to visitor' do
    visitor = Visitor.new(user_agent: 'MyString')
    assert visitor.save
    assert_nil visitor.member_id
    visitor.update(member: @member)
    assert_equal visitor.member_id, @member.id
  end
end
