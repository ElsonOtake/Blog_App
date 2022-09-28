class PostsController < ApplicationController
  before_action :authenticate_user!

  @posts_per_page = 2
  @user = User.find(params[:user_id])
  @page = params.fetch(:page, 1)
  @posts = @user.posts[2 * (@page.to_i - 1), @posts_per_page]

  def show
    @post = Post.find(params[:id])
    @comms = @post.comments.includes(:author)
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.new
    post.title = params[:user_posts][:title]
    post.text = params[:user_posts][:text]
    post.author = current_user
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post was successfully created'
          redirect_to user_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, new_user_post_path(current_user)
        end
      end
    end
  end
end
