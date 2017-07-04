class SubscriptionsController < ApplicationController
  expose(:subscription)

  helper_method :company

  def new
    @prices = SubscriptionPrice.all
    @title = "Premium Accounts"
    
  end

  def create
    plan = SubscriptionPrice.find(params[:subscription][:plan_id])
    subscription.company = company
    subscription.price = plan.price
    subscription.duration = plan.duration
    subscription.save
  end

  private

  def company
    @company ||= current_company
  end
end
