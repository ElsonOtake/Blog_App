class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :manage, :all
    else
      can :destroy, Post do |post|
        post.user == user
      end

      can :destroy, Comment do |comment|
        comment.user == user
      end

      can :create, Post
      can :create, Comment
    end

    # can :destroy, Post, author_id: user.id
    # can :destroy, Comment, author_id: user.id
    # can :manage, :all if user.is? :admin
  end
end
