class PostsController < ApplicationController
  POSTS_PER_PAGE = 2
  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 1).to_i
    @page = 1 if @page < 1
    aux = ((@user.posts.size + 1) / POSTS_PER_PAGE)
    @page = aux if @page > aux
    @posts = @user.posts[2 * (@page - 1), POSTS_PER_PAGE]
  end

  def show
    @post = Post.find(params[:id])
  end
end
