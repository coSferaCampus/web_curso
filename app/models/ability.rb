class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin?
      can :manage, Subject
      can :manage, Theme
      can :manage, User
    else
      can :read, Subject
      can :read, Theme
    end
  end
end
