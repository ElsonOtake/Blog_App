class PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post, only: %i[show destroy]
  before_action :set_member, only: %i[index show]

  include Pagy::Backend

  load_and_authorize_resource

  def index
    @pagy, @posts = pagy(@member.posts)
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      redirect_to member_posts_path(current_user), notice: 'Post was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post was successfully deleted'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
