class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @page = 0
    @posts = @user.posts[2 * @page, 2]
  end

  def show
    @post = Post.find(params[:id])
  end
end
