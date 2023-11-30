require "test_helper"
require "sidekiq/testing"

class AnalyticsIntegrationTest < ActionDispatch::IntegrationTest

  setup do
    # A test fake that pushes all jobs into a jobs array
    Sidekiq::Testing.fake!
    @member = Member.first
    @post = Post.first
    @comment = Comment.first
  end

  def after_teardown
    # clear all workers' jobs
    Sidekiq::Worker.clear_all
  end

  test "should redirect from root page if user not signed in" do
    get root_url
    assert_response :redirect
  end

  test "should get root page if user signed in" do
    sign_in @member
    get root_url
    assert_response :success
  end

  test "should not create analytic data on new posts" do
    # query the current state
    assert Sidekiq::Testing.fake?
    # remove jobs from the queue
    CreateCounterJob.clear
    assert_equal 0, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 0, CreateUniqueJob.jobs.size
    assert_equal 0, CreateBrowserJob.jobs.size
    sign_in @member
    get "/members/#{@member.id}/posts/new"
    assert_response :success
    post "/members/#{@member.id}/posts",
      params: { post: { title: "MyString", text: "MyString", author: @member } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 0, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 0, CreateUniqueJob.jobs.size
    assert_equal 0, CreateBrowserJob.jobs.size
  end

  test "should create analytic data on creating comments" do
    # query the current state
    assert Sidekiq::Testing.fake?
    # remove jobs from the queue
    CreateCounterJob.clear
    assert_equal 0, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 0, CreateUniqueJob.jobs.size
    assert_equal 0, CreateBrowserJob.jobs.size
    sign_in @member
    get "/members/#{@member.id}/posts/#{@post.id}/comments/new"
    assert_response :success
    post "/members/#{@member.id}/posts/#{@post.id}/comments",
      params: { comment: { text: "MyString", author: @member, post: @post } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 1, CreateCounterJob.jobs.size
    assert_equal 1, CreateLengthJob.jobs.size
    assert_equal 1, CreateUniqueJob.jobs.size
    assert_equal 1, CreateBrowserJob.jobs.size
    # remove jobs from the queue
    CreateCounterJob.clear
    CreateLengthJob.clear
    CreateUniqueJob.clear
    CreateBrowserJob.clear
  end

  test "should create analytic data on updating comments" do
    # query the current state
    assert Sidekiq::Testing.fake?
    # remove jobs from the queue
    CreateCounterJob.clear
    assert_equal 0, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 0, CreateUniqueJob.jobs.size
    assert_equal 0, CreateBrowserJob.jobs.size
    sign_in @member
    get "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}/edit"
    assert_response :success
    put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
      params: { comment: { text: "MyString", author: @member, post: @post } }
    assert_response :redirect
    assert_equal 1, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 1, CreateUniqueJob.jobs.size
    assert_equal 1, CreateBrowserJob.jobs.size
    # remove jobs from the queue
    CreateCounterJob.clear
    CreateUniqueJob.clear
    CreateBrowserJob.clear
  end

  test "should create analytic data on deleting comments" do
    # query the current state
    assert Sidekiq::Testing.fake?
    # remove jobs from the queue
    CreateCounterJob.clear
    assert_equal 0, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 0, CreateUniqueJob.jobs.size
    assert_equal 0, CreateBrowserJob.jobs.size
    sign_in @member
    post = Post.first
    comment = Comment.first
    delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
      params: { comment: { member: @member, post: @post, id: @comment.id } }
    assert_response :redirect
    assert_equal 1, CreateCounterJob.jobs.size
    assert_equal 0, CreateLengthJob.jobs.size
    assert_equal 1, CreateUniqueJob.jobs.size
    assert_equal 1, CreateBrowserJob.jobs.size
    # remove jobs from the queue
    CreateCounterJob.clear
    CreateUniqueJob.clear
    CreateBrowserJob.clear
  end
end