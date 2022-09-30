class Api::V1::PostsController < ApplicationController
  before_action :find_user_post

  def index
    posts = @user.posts
    if posts.size.positive?
      render json: posts
    else
      render json: { errors: 'Posts not found' }, status: :not_found
    end
  end

  def show
    post = @user.posts.find(params[:id])
    if post
      render json: post
    else
      render json: { errors: 'Post not found' }, status: :not_found
    end
  end

  private

  def find_user_post
    @user = User.find_by_id!(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end
