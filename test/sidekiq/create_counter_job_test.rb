require 'test_helper'
require 'sidekiq/testing'

class CreateCounterJobTest < Minitest::Test
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
    assert_equal 0, CreateCounterJob.jobs.size
    CreateCounterJob.perform_async("MyString", @member.id)
    assert_equal 1, CreateCounterJob.jobs.size
    assert_equal "MyString", CreateCounterJob.jobs.first['args'].first
    assert_equal @member.id, CreateCounterJob.jobs.first['args'].second
    # remove jobs from the queue
    CreateCounterJob.clear
    assert_equal 0, CreateCounterJob.jobs.size
  end

  def test_adding_count_to_counter_analytic_model
    assert_equal CounterAnalytic.where(action: "MyString").count, 0
    # An inline mode that runs the job immediately instead of enqueuing it
    Sidekiq::Testing.inline! do
      # query the current state
      assert Sidekiq::Testing.inline?
      CreateCounterJob.perform_async("MyString", @member.id)
    end
    # query the current state
    assert Sidekiq::Testing.fake?
    assert_equal CounterAnalytic.where(action: "MyString").count, 1
    assert_equal CounterAnalytic.last.reload.action, "MyString"
    assert_equal CounterAnalytic.last.count, 1
    CounterAnalytic.where(action: "MyString").destroy_all
  end

  def test_adding_count_to_counter_analytic_model_using_same_action
    assert_equal CounterAnalytic.where(action: "MyString").count, 0
    Sidekiq::Testing.inline! do
      assert Sidekiq::Testing.inline?
      CreateCounterJob.perform_async("MyString", @member.id)
    end
    assert Sidekiq::Testing.fake?
    assert_equal CounterAnalytic.where(action: "MyString").count, 1
    assert_equal CounterAnalytic.last.reload.action, "MyString"
    assert_equal CounterAnalytic.last.member_id, @member.id
    assert_equal CounterAnalytic.last.count, 1
    Sidekiq::Testing.inline! do
      assert Sidekiq::Testing.inline?
      CreateCounterJob.perform_async("MyString", @member.id)
    end
    assert Sidekiq::Testing.fake?
    # Update de view count
    assert_equal CounterAnalytic.where(action: "MyString").count, 1
    assert_equal CounterAnalytic.last.reload.count, 2
    CounterAnalytic.where(action: "MyString").destroy_all
  end
end
