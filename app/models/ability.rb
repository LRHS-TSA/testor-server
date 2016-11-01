# Abilities for User
class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.teacher?
      # Group
      can :create, Group
      can :manage, Group, members: {user: user}

      # Member
      can :join_group, Member
      can :manage, Member, group: {members: {user: user}}
    elsif user.student?
      # Group
      can :read, Group, members: {user: user}

      # Member
      can :join_group, Member
    end
  end
end
