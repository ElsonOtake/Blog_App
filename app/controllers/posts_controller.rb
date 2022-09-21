class PostsController < ApplicationController
  def index
    @posts_per_page = 2
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 1).to_i
    @page = 1 if @page < 1
    aux = ((@user.posts.size + 1) / @posts_per_page)
    @page = aux if @page > aux
    @posts = @user.posts[2 * (@page - 1), @posts_per_page]
  end

  def show
    @post = Post.find(params[:id])
  end
end
