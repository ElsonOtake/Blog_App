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
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.new
    post.title = params[:member_posts][:title]
    post.text = params[:member_posts][:text]
    post.author = current_member
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post was successfully created'
          redirect_to member_path(current_member)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, new_member_post_path(current_member)
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
