require 'test_helper'

class AddLengthJobTest < Minitest::Test
  include ActiveJob::TestHelper

  def setup
    @member = Member.first
  end

  def test_enqueued_job
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1 do
      AddLengthJob.perform_later(@member.id, 24)
    end
  end

  def test_enqueued_with
    assert_enqueued_with(job: AddLengthJob, args: [@member.id, 36], queue: 'default') do
      AddLengthJob.perform_later(@member.id, 36)
    end
  end
end
