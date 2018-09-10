# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_a? AdminUser
      can :manage, :all
    else
      cannot :manage, :all
      can :read, [Company, Offer]
      cannot :mailing_list, [Company, Candidate]
      can :manage, Attachment, owner_id: user.id
      cannot :manage, Order
      if user.company?
        can :create, [Offer, BlogPost]
        can %i[promote add_premium update batch_action destroy publish unpublish], Offer, company_id: user.id
        can %i[update destroy], BlogPost, user_id: user.id
        can :my_offers, Offer
        can :my_offer_applications, Application
        can :show, Candidate
        can :manage, Order, user_id: user.id
        can :manage, Company, id: user.id

        # only premium users
        can :index, Candidate if user.premium?
      elsif user.candidate?
        can :manage, [SkillItem, CvItem], candidate_id: user.id
        can :manage, Candidate, id: user.id
        can :save, Offer
        can :vote, Company
        can :create, Application
        can :manage, OfferSave
      else
        cannot :manage, Attachment
      end
    end
  end
end
