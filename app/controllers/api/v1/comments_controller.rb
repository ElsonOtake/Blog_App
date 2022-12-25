class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :find_member_post

  ALLOWED_DATA = %(text).freeze

  def index
    comments = @post.comments
    if comments.size.positive?
      render json: comments, status: :ok
    else
      render json: { error: 'Comments not found' }, status: :not_found
    end
  end

  def show
    comment = @post.comments.find_by_id!(params[:id])
    render json: comment, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Comment not found' }, status: :not_found
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create it' }, status: :unprocessable_entity if data.empty?

    comment = Comment.new(data)
    comment.post = @post
    comment.author = current_user
    if comment.save
      render json: comment, status: :ok
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
