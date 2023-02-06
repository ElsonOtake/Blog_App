class CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post, only: %i[new create destroy]
  before_action :set_comment, only: %i[destroy]
  load_and_authorize_resource

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      flash.notice = 'Comment was successfully created'
    else
      flash.now.alert = 'Comment could not be saved'
    end
    redirect_to member_post_path(current_user, @post)
  end

  def destroy
    @comment.destroy

    redirect_to member_post_path(current_user, @post), notice: 'Comment was successfully deleted'
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
end
