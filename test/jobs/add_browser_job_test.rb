require 'test_helper'

class AddBrowserJobTest < Minitest::Test
  include ActiveJob::TestHelper

  def setup
    @member = Member.first
    @visitor = Visitor.last
    @agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'
  end

  def test_enqueued_job
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1 do
      AddBrowserJob.perform_later(@member.id, @visitor.id, @agent)
    end
  end

  def test_enqueued_with
    assert_enqueued_with(job: AddBrowserJob, args: [@member.id, @visitor.id, @agent], queue: 'default') do
      AddBrowserJob.perform_later(@member.id, @visitor.id, @agent)
    end
  end
end
