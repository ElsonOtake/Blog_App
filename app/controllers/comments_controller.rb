class CommentsController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    member = Member.find(params[:member_id])
    comment = Comment.new(comment_params)
    comment.post = post
    comment.author = current_member
    if comment.save
      flash[:success] = 'Comment was successfully created'
    else
      flash[:error] = 'Error: Comment could not be saved'
    end
    redirect_to member_post_path(member, post)
  end

  def destroy
    member = Member.find(params[:member_id])
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy

    redirect_to member_post_path(member, post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:member_post_comments).permit(:text)
  end
end
