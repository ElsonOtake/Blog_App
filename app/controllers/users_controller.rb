class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = User.first
  end

  def show
    @user = User.find(params[:id])
    @current_user = User.first
  end
end
