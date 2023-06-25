class CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[new create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    respond_to do |format|
      if @comment.save!
        format.html { redirect_to member_posts_path(@member), notice: 'Comment was successfully created' }
        format.turbo_stream { flash.now[:notice] = 'Comment was successfully created' }
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
      if @comment.update(comment_params)
        format.html { redirect_to member_post_path(@member, @post), notice: 'Comment was successfully updated' }
        format.turbo_stream { flash.now[:notice] = 'Comment was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        flash.now[:notice] = @person.errors.full_messages[0]
        format.turbo_stream { render turbo_stream: helpers.render_turbo_stream_inline_flash_messages }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to member_post_path(@member, @post), notice: 'Comment was successfully deleted' }
      format.turbo_stream { flash.now[:notice] = 'Comment was successfully deleted' }
    end
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
