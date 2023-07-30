class Ability
  include CanCan::Ability

  def initialize(member)
    can %i[read create], :all

    return unless member.present?

    can %i[update destroy], Post, author: member
    can %i[update destroy], Comment, author: member

    return unless member.is? :admin

    can :manage, :all
  end
end
