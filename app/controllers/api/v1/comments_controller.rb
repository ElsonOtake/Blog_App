class Api::V1::CommentsController < ApplicationController
  include TrackEvent
  before_action :authorize_request
  before_action :find_member_post
  after_action :track_event, only: %i[create]

  ALLOWED_DATA = %(text).freeze

  def index
    comments = @post.comments
    render json: comments
  end

  def show
    comment = @post.comments.find_by_id!(params[:id])
    render json: comment
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Comment not found' }, status: :not_found
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create it' }, status: :unprocessable_entity if data.empty?

    comment = @post.comments.new(data)
    comment.author = current_user
    session[:action] = 'create'
    session[:post_author] = @post.author_id
    session[:comment_length] = comment.text.size
    if comment.save
      render json: comment
    else
      render json: { error: 'Could not create it' }, status: :unprocessable_entity
    end
  end

  private

  def find_member_post
    member = Member.find_by_id!(params[:member_id])
    @post = member.posts.find_by_id!(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Member and/or post not found' }, status: :not_found
  end
end
