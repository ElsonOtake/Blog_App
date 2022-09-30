class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :find_user

  def index
    posts = @user.posts
    if posts.size.positive?
      render json: posts
    else
      render json: { errors: 'Posts not found' }, status: :not_found
    end
  end

  def show
    post = @user.posts.find_by_id!(params[:id])
    render json: post
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end

  private

  def find_user
    @user = User.find_by_id!(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end
