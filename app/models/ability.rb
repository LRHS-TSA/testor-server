# Abilities for User
class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.teacher?
      # Group
      can :create, Group
      can :manage, Group, members: {user_id: user.id}

      # Member
      can :join_group, Member
      can :manage, Member, group: {members: {user_id: user.id}}

      # Test
      can :create, Test
      can :manage, Test, user: user

      # Assignment
      can :manage, Assignment, group: {members: {user_id: user.id}}

      # Question
      can :manage, Question, test: {user_id: user.id}
    elsif user.student?
      # Group
      can :read, Group, members: {user_id: user.id}

      # Member
      can :join_group, Member
      can :destroy, Member, user: user

      # Assignment
      can :read, Assignment, group: {members: {user_id: user.id}}
    end
  end
end
