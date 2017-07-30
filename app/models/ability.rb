class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_a? AdminUser
      can :manage, :all
    else
      cannot :manage, :all
      can :read, [Company, Offer]
      can :manage, Attachment, owner_id: user.id
      if user.company?
        can :create, [Offer, BlogPost]
        can [:update, :destroy, :publish, :unpublish], Offer, company_id: user.id
        can [:update, :destroy], BlogPost, user_id: user.id
        can :my_offers, Offer
        can :my_offer_applications, Application
        can :show, Candidate
        can :manage, Company, id: user.id
        can :read, Application do |a|
          a.offer.company_id = user.id
        end

        # only premium users
        if user.premium?
          can :index, Candidate
        end
      elsif user.candidate?
        can :manage, [ SkillItem, CvItem ], candidate_id: user.id
        can :manage, Candidate, id: user.id
        can :save, Offer
        can :vote, Company
        can :create, Application
      else
        cannot :manage, Attachment
      end
    end
  end
end
