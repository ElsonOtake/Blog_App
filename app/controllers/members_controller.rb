class MembersController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def index
    @members = Member.all.includes([:avatar_attachment])
  end

  def show
    @member = Member.find(params[:id])
  end
end
