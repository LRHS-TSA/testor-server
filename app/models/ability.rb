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

      # Multiple Choice Option
      can :manage, MultipleChoiceOption, question: {test: {user_id: user.id}}

      # Matching Pair
      can :manage, MatchingPair, question: {test: {user_id: user.id}}

      # Session
      can :manage, Session, assignment: {group: {members: {user_id: user.id}}}

      # Text Answer
      can :read, TextAnswer, question: {test: {user_id: user.id}}

      # Multiple Choice Answer
      can :read, MultipleChoiceAnswer, question: {test: {user_id: user.id}}

      # Matching Pair Answer
      can :read, MatchingPairAnswer, question: {test: {user_id: user.id}}

      # Score
      can :manage, Score, question: {test: {user_id: user.id}}
    elsif user.student?
      # Group
      can :read, Group, members: {user_id: user.id}

      # Member
      can :join_group, Member
      can :destroy, Member, user: user

      # Assignment
      can :read, Assignment, group: {members: {user_id: user.id}}

      # Session
      can :create, Session, assignment: {group: {members: {user_id: user.id}}}
      can [:read, :update, :load_questions], Session, user_id: user.id

      # Text Answer
      can :manage, TextAnswer, session: {user_id: user.id}

      # Multiple Choice Answer
      can :manage, MultipleChoiceAnswer, session: {user_id: user.id}

      # Matching Pair Answer
      can :manage, MatchingPairAnswer, session: {user_id: user.id}

      # Score
      can :read, Score, session: {user_id: user.id}
    end
  end
end
