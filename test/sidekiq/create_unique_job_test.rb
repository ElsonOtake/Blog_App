require 'test_helper'
require 'sidekiq/testing'

class CreateUniqueJobTest < Minitest::Test
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
    assert_equal 0, CreateUniqueJob.jobs.size
    CreateUniqueJob.perform_async(@member.id, @visitor.id)
    assert_equal 1, CreateUniqueJob.jobs.size
    assert_equal @member.id, CreateUniqueJob.jobs.first['args'].first
    assert_equal @visitor.id, CreateUniqueJob.jobs.first['args'].second
    # remove jobs from the queue
    CreateUniqueJob.clear
    assert_equal 0, CreateUniqueJob.jobs.size
  end

  def test_load_unique_analytic_model
    # An inline mode that runs the job immediately instead of enqueuing it
    Sidekiq::Testing.inline! do
      # query the current state
      assert Sidekiq::Testing.inline?
      CreateUniqueJob.perform_async(@member.id, @visitor.id)
    end
    # query the current state
    assert Sidekiq::Testing.fake?
    assert_equal UniqueAnalytic.last.reload.member_id, @member.id
    assert_equal UniqueAnalytic.last.visitor_id, @visitor.id
    UniqueAnalytic.last.destroy
  end
end
