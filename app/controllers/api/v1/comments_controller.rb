class Api::V1::CommentsController < ApplicationController
  ALLOWED_DATA = %(text).freeze
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def show
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    render json: comment
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    p data
    post = Post.find(params[:post_id])
    p post
    comment = Comment.new(data)
    p comment
    comment.post = post
    comment.author = User.first
    p comment
    if comment.save
      render json: comment
    else
      render json: { error: 'could not create it' }
    end
  end
end
