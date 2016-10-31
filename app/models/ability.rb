# Abilities for User
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 1
      # User is a teacher
      puts 'ABOUT TO LOAD'
      # Group
      #can [:read, :create], Group
      can :manage, Group, members: {user: user}
    else
      # User is a student

      # Group
      can :read, Group
    end
  end
end
