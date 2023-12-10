require 'test_helper'

class AddCounterJobTest < Minitest::Test
  include ActiveJob::TestHelper

  def setup
    @member = Member.first
    @visitor = Visitor.first
  end

  def test_enqueued_job
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1 do
      AddCounterJob.perform_later('MyString', @member.id, @visitor.id)
    end
  end

  def test_enqueued_with
    assert_enqueued_with(job: AddCounterJob, args: ['MyString', @member.id, @visitor.id], queue: 'default') do
      AddCounterJob.perform_later('MyString', @member.id, @visitor.id)
    end
  end
end
