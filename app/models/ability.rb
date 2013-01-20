class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role?('admin')
      can :manage, :all
    elsif user.id.present?
      can :manage, User, :id => user.id
      can :manage, Appointment, :user_id => user.id
      can :manage, Appointment, :tech_id => user.id
    end
  end
end
