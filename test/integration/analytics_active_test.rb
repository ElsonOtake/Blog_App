require 'test_helper'

#
# Test analytics integration using background jobs (AddCounterJob, AddLengthJob,
# AddBrowserJob, and AddUniqueJob) in app/controllers/concerns/track_event.rb.
#

class AnalyticsActiveIntegrationTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

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
    assert_no_enqueued_jobs
    sign_in @member
    get "/members/#{@member.id}/posts/new"
    assert_response :success
    post "/members/#{@member.id}/posts",
         params: { post: { title: 'MyString', text: 'MyString', author: @member } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_no_enqueued_jobs
  end

  test 'should run counter job on creating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddCounterJob do
      sign_in @member
      post "/members/#{@member.id}/posts/#{@post.id}/comments",
           params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
  end

  test 'should run length job on creating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddLengthJob do
      sign_in @member
      post "/members/#{@member.id}/posts/#{@post.id}/comments",
           params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
  end

  test 'should run browser job on creating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddBrowserJob do
      sign_in @member
      post "/members/#{@member.id}/posts/#{@post.id}/comments",
           params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
  end

  test 'should run unique job on creating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddUniqueJob do
      sign_in @member
      post "/members/#{@member.id}/posts/#{@post.id}/comments",
           params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
  end

  test 'should run counter job on updating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddCounterJob do
      sign_in @member
      put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
          params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
    end
  end

  test 'should not run length job when updating comments' do
    assert_no_enqueued_jobs
    assert_no_enqueued_jobs only: AddLengthJob do
      sign_in @member
      put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
          params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
    end
  end

  test 'should run browser job on updating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddBrowserJob do
      sign_in @member
      put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
          params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
    end
  end

  test 'should run unique job on updating comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddUniqueJob do
      sign_in @member
      put "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
          params: { comment: { text: 'MyString', author: @member, post: @post } }
      assert_response :redirect
    end
  end

  test 'should run counter job on deleting comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddCounterJob do
      sign_in @member
      delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
             params: { comment: { member: @member, post: @post, id: @comment.id } }
      assert_response :redirect
    end
  end

  test 'should not create length data on deleting comments' do
    assert_no_enqueued_jobs
    assert_no_enqueued_jobs only: AddLengthJob do
      sign_in @member
      delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
             params: { comment: { member: @member, post: @post, id: @comment.id } }
      assert_response :redirect
    end
  end

  test 'should run browser job on deleting comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddBrowserJob do
      sign_in @member
      delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
             params: { comment: { member: @member, post: @post, id: @comment.id } }
      assert_response :redirect
    end
  end

  test 'should run unique job on deleting comments' do
    assert_no_enqueued_jobs
    assert_enqueued_jobs 1, only: AddUniqueJob do
      sign_in @member
      delete "/members/#{@member.id}/posts/#{@post.id}/comments/#{@comment.id}",
             params: { comment: { member: @member, post: @post, id: @comment.id } }
      assert_response :redirect
    end
  end
end
