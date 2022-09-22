class PostsController < ApplicationController
  def index
    @posts_per_page = 2
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 1)
    @posts = @user.posts[2 * (@page.to_i - 1), @posts_per_page]
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = current_user
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.new(post_params)

    # respond_to do |format|
    respond_to do

      if post.save
        flash[:success] = 'Post was successfully created'
        redirect_to root_url
        # format.html { redirect_to post_url(post), notice: "Post was successfully created." }
        # format.json { render :show, status: :created, location: post }
      else
        flash.now[:error] = 'Error: Post could not be saved'
        render :new, post
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end
end
