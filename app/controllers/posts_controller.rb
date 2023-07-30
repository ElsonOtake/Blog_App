class PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_member, only: %i[index show]

  include Pagy::Backend

  def index
    @pagy, @posts = pagy_countless(@member.posts.includes(:author))
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    respond_to do |format|
      if post.save
        format.html { redirect_to member_posts_path(current_user), notice: 'Post was successfully created' }
        format.turbo_stream { flash.now[:notice] = 'Post was successfully created' }
      else
        format.html { render :new, status: :unprocessable_entity }
        flash.now[:notice] = @person.errors.full_messages[0]
        format.turbo_stream { render turbo_stream: helpers.render_turbo_stream_inline_flash_messages }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to member_post_path(@member, @post), notice: 'Post was successfully updated' }
        format.turbo_stream { flash.now[:notice] = 'Post was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        flash.now[:notice] = @post.errors.full_messages[0]
        format.turbo_stream { render turbo_stream: helpers.render_turbo_stream_inline_flash_messages }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfully deleted' }
      format.turbo_stream { flash.now[:notice] = 'Post was successfully deleted' }
    end
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
