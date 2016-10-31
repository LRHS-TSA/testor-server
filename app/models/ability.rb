# Abilities for User
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 1
      # User is a teacher

      # Group
      can [:read, :create], Group
      can :manage, Group, members: {user: user}
    else
      # User is a student

      # Group
      can :read, Group
    end
  end
end
