class CommentsController < ApplicationController
  include TrackEvent
  before_action :authenticate_member!
  before_action :set_post, only: %i[index new create]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_event, only: %i[create update destroy]
  after_action :track_event, only: %i[create update destroy]

  def index
    @comments = @post.comments.includes(:author)
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    session[:comment_length] = @comment.text.size
    respond_to do |format|
      if @comment.save!
        format.html { redirect_to member_posts_path(@post.author), notice: 'Comment was successfully created' }
        format.turbo_stream { flash.now[:notice] = 'Comment was successfully created' }
      else
        format.html { render :new, status: :unprocessable_entity }
        flash.now[:notice] = @comment.errors.full_messages[0]
        format.turbo_stream { render turbo_stream: helpers.render_turbo_stream_inline_flash_messages }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html do
          redirect_to member_post_path(@comment.post.author, @comment.post), notice: 'Comment was successfully updated'
        end
        format.turbo_stream { flash.now[:notice] = 'Comment was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        flash.now[:notice] = @comment.errors.full_messages[0]
        format.turbo_stream { render turbo_stream: helpers.render_turbo_stream_inline_flash_messages }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html do
        redirect_to member_post_path(@comment.post.author, @comment.post), notice: 'Comment was successfully deleted'
      end
      format.turbo_stream { flash.now[:notice] = 'Comment was successfully deleted' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_event
    session[:action] = params['action'] == 'destroy' ? 'delete' : params['action']
    session[:post_author] = Post.find(params[:post_id]).author_id
  end
end
