class MembersController < ApplicationController
  before_action :authenticate_member!
  load_and_authorize_resource

  def index
    @members = Member.all.includes([:avatar_attachment]).order(updated_at: :desc)
  end
end
