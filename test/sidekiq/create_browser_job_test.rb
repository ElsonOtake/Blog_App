require 'test_helper'
require 'sidekiq/testing'

class CreateBrowserJobTest < Minitest::Test
  def setup
    # A test fake that pushes all jobs into a jobs array
    Sidekiq::Testing.fake!
    @member = Member.first
    @visitor = Visitor.last
    @agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'
  end

  def after_teardown
    # clear all workers' jobs
    Sidekiq::Worker.clear_all
  end

  def test_enqueued_job
    # query the current state
    assert Sidekiq::Testing.fake?
    # assert that jobs were pushed on to the queue
    assert_equal 0, CreateBrowserJob.jobs.size
    CreateBrowserJob.perform_async(@member.id, @visitor.id, @agent)
    assert_equal 1, CreateBrowserJob.jobs.size
    assert_equal @member.id, CreateBrowserJob.jobs.first['args'].first
    assert_equal @visitor.id, CreateBrowserJob.jobs.first['args'].second
    assert_equal @agent, CreateBrowserJob.jobs.first['args'].third
    # remove jobs from the queue
    CreateBrowserJob.clear
    assert_equal 0, CreateBrowserJob.jobs.size
  end

  def test_load_browser_analytic_model
    # An inline mode that runs the job immediately instead of enqueuing it
    Sidekiq::Testing.inline! do
      # query the current state
      assert Sidekiq::Testing.inline?
      CreateBrowserJob.perform_async(@member.id, @visitor.id, @agent)
    end
    # query the current state
    assert Sidekiq::Testing.fake?
    assert_equal BrowserAnalytic.last.reload.member_id, @member.id
    assert_equal BrowserAnalytic.last.visitor_id, @visitor.id
    assert_equal BrowserAnalytic.last.device, 'desktop'
    assert_equal BrowserAnalytic.last.platform, 'macOS'
    BrowserAnalytic.last.destroy
  end
end
