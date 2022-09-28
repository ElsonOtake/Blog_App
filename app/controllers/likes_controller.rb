class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    author = User.find(params[:user_id])
    like = Like.new
    like.post = post
    like.author = current_user
    respond_to do |format|
      format.html do
        if like.save
          flash[:success] = 'Like was successfully created'
        else
          flash.now[:error] = 'Error: Like could not be saved'
        end
        redirect_to user_post_path(author, post)
      end
    end
  end
end
