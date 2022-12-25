class PostsController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def index
    @posts_per_page = 2
    @member = Member.find(params[:member_id])
    @page = params.fetch(:page, 1)
    @posts = @member.posts[2 * (@page.to_i - 1), @posts_per_page]
  end

  def show
    @post = Post.find(params[:id])
    @comms = @post.comments.includes(:author)
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      redirect_to member_path(current_user), notice: 'Post was successfully created'
    else
      flash.alert = 'Post could not be saved'
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    redirect_to root_path, notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:member_posts).permit(:title, :text)
  end
end
