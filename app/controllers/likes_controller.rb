class LikesController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def create
    post = Post.find(params[:post_id])
    like = Like.new
    like.post = post
    like.author = current_user
    if like.save
      flash.notice = 'Like was successfully created'
    else
      flash.now.alert = 'Error: Like could not be saved'
    end
    redirect_to member_post_path(current_user, post)
  end
end
