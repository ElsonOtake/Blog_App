class CommentsController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.post = post
    comment.author = current_user
    if comment.save
      flash.notice = 'Comment was successfully created'
    else
      flash.now.alert = 'Comment could not be saved'
    end
    redirect_to member_post_path(current_user, post)
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy

    redirect_to member_post_path(current_user, post), notice: 'Comment was successfully deleted'
  end

  private

  def comment_params
    params.require(:member_post_comments).permit(:text)
  end
end
