class CommentsController < ApplicationController
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
end
