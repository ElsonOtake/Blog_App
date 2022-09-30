class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :find_user_post

  ALLOWED_DATA = %(text).freeze

  def index
    comments = @post.comments
    render json: comments
  end

  def show
    comment = @post.comments.find(params[:id])
    render json: comment
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    post = Post.find(params[:post_id])
    comment = Comment.new(data)
    comment.post = post
    comment.author = @current_user
    if comment.save
      render json: comment
    else
      render json: { error: 'could not create it' }
    end
  end

  private

  def find_user_post
    user = User.find_by_id!(params[:user_id])
    @post = user.posts.find_by_id!(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User and/or post not found' }, status: :not_found
  end
end
