class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_a? AdminUser
      can :manage, :all
    else
      cannot :manage, :all
      can :read, [Company, Offer]
      can :manage, Attachment do |a|
        a.owner_id = user.id
      end
      if user.company?
        can :create, Offer
        can [:update, :destroy, :publish, :unpublish], Offer, company_id: user.id
        can :show, [Page, Candidate]
        can :manage, Company, id: user.id
        can :read, Application do |a|
          a.offer.company_id = user.id
        end

        # only premium users
        if user.premium?
          can :index, Candidate
        end
      elsif user.candidate?
        can :manage, SkillItem, candidate_id: user.id
        can :manage, CvItem, candidate_id: user.id
        can :manage, Candidate, id: user.id
        can :show, Page
        can :save, Offer
        can :vote, Company
        can :create, Application
        can :manage, Resume, owner_id: user.id
      else
        cannot :manage, Attachment
        can :show, Page
      end
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
