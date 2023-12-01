require 'test_helper'

#
# Test analytics integration  without  using background jobs (CreateCounterJob, CreateLengthJob,
# CreateBrowserJob, and CreateUniqueJob) in app/controllers/concerns/track_event.rb.
#
# My Render account does not allow me to run Sidekiq on deployments.
#

class AnalyticsRenderIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @member = Member.first
    @post = Post.first
    @comment = Comment.first
  end

  test 'should redirect from root page if user not signed in' do
    get root_url
    assert_response :redirect
  end

  test 'should get root page if user signed in' do
    sign_in @member
    get root_url
    assert_response :success
  end

  test 'should not create analytic data on new posts' do
    sign_in @member
    get "/members/#{@member.id}/posts/new"
    assert_response :success
    post "/members/#{@member.id}/posts",
         params: { post: { title: 'MyString', text: 'MyString', author: @member } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'should create analytic data on creating comments' do
    sign_in @member
    get "/members/#{@member.id}/posts/#{@post.id}/comments/new"
    assert_response :success
    post "/members/#{@member.id}/posts/#{@post.id}/comments",
         params: { comment: { text: 'MyString', author: @member, post: @post } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'should create analytic data on updating comments' do
    sign_in @member
    get "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}/edit"
    assert_response :success
    put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
        params: { comment: { text: 'MyString', author: @member, post: @post } }
    assert_response :redirect
  end

  test 'should create analytic data on deleting comments' do
    sign_in @member
    delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
           params: { comment: { member: @member, post: @post, id: @comment.id } }
    assert_response :redirect
  end
end
