class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    user = User.find(params[:user_id])
    comment = Comment.new(params.require(:user_post_comments).permit(:text))
    comment.post = post
    comment.author = current_user
    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment was successfully created'
        else
          flash.now[:error] = 'Error: Comment could not be saved'
        end
        redirect_to user_post_path(user, post)
      end
    end
  end

  def destroy
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy

    respond_to do |format|
      format.html { redirect_to user_post_path(user, post), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
