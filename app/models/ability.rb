class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    can :crud, :all if user.is? :admin
  end
end
