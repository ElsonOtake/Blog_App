require 'test_helper'
require 'sidekiq/testing'

class CreateLengthJobTest < Minitest::Test
  def setup
    # A test fake that pushes all jobs into a jobs array
    Sidekiq::Testing.fake!
    @member = Member.first
    @visitor = Visitor.first
  end

  def after_teardown
    # clear all workers' jobs
    Sidekiq::Worker.clear_all
  end

  def test_enqueued_job
    # query the current state
    assert Sidekiq::Testing.fake?
    # assert that jobs were pushed on to the queue
    assert_equal 0, CreateLengthJob.jobs.size
    CreateLengthJob.perform_async(@member.id, 24)
    assert_equal 1, CreateLengthJob.jobs.size
    assert_equal @member.id, CreateLengthJob.jobs.first['args'].first
    assert_equal 24, CreateLengthJob.jobs.first['args'].second
    # remove jobs from the queue
    CreateLengthJob.clear
    assert_equal 0, CreateLengthJob.jobs.size
  end

  def test_load_length_analytic_model
    # An inline mode that runs the job immediately instead of enqueuing it
    Sidekiq::Testing.inline! do
      # query the current state
      assert Sidekiq::Testing.inline?
      CreateLengthJob.perform_async(@member.id, 36)
    end
    # query the current state
    assert Sidekiq::Testing.fake?
    assert_equal LengthAnalytic.last.reload.member_id, @member.id
    assert_equal LengthAnalytic.last.comment_length, 36
    LengthAnalytic.last.destroy
  end
end
