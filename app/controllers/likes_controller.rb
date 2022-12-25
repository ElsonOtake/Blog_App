class LikesController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def create
    post = Post.find(params[:post_id])
    author = Member.find(params[:member_id])
    like = Like.new
    like.post = post
    like.author = current_member
    if like.save
      flash[:success] = 'Like was successfully created'
    else
      flash.now[:error] = 'Error: Like could not be saved'
    end
    redirect_to member_post_path(author, post)
  end
end
