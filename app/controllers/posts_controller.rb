class PostsController < ApplicationController
  POSTS_PER_PAGE = 2
  def index
    @user = User.find(params[:user_id])
    @page = 0
    @posts = @user.posts[2 * @page, POSTS_PER_PAGE]
  end

  def show
    @post = Post.find(params[:id])
  end
end
