class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.company?
      can :create, Offer
      can :update, Offer, company_id: user.id
      can :destroy, Offer, company_id: user.id
    end
    if user.candidate?
      can :manage, SkillItem, candidate_id: user.id
      can :manage, CvItem, candidate_id: user.id
    end
    can :read, :all
    cannot :index, Page
    if user.admin?
      can :manage, :all
    else
      cannot :manage, Page
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
