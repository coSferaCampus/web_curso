class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin?
      can :manage, Subject
      can :manage, Theme
      can :manage, User
      can :manage, FileResource
    else
      can :read, Subject
      can :read, Theme
      can :read, FileResource
    end
  end
end
