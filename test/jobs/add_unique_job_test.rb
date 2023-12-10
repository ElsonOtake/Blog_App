require 'test_helper'

class AddUniqueJobTest < Minitest::Test
  include ActiveJob::TestHelper

  def setup
    @member = Member.first
    @visitor = Visitor.first
  end

  def test_enqueued_job
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1 do
      AddUniqueJob.perform_later(@member.id, @visitor.id)
    end
  end

  def test_enqueued_with
    assert_enqueued_with(job: AddUniqueJob, args: [@member.id, @visitor.id], queue: 'default') do
      AddUniqueJob.perform_later(@member.id, @visitor.id)
    end
  end
end
