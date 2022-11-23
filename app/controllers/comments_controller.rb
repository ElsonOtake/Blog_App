class CommentsController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    member = Member.find(params[:member_id])
    comment = Comment.new(params.require(:member_post_comments).permit(:text))
    comment.post = post
    comment.author = current_member
    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment was successfully created'
        else
          flash.now[:error] = 'Error: Comment could not be saved'
        end
        redirect_to member_post_path(member, post)
      end
    end
  end

  def destroy
    member = Member.find(params[:member_id])
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy

    respond_to do |format|
      format.html { redirect_to member_post_path(member, post), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
