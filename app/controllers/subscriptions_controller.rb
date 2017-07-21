class SubscriptionsController < ApplicationController
  expose(:subscription)

  helper_method :company

  def new
    @title = "Premium Accounts"
  end

  def create
    subscription.company = company
    subscription.price = Subscription
    subscription.save
  end

  private

  def company
    @company ||= current_company
  end

  def subscription_params
    params.require(:subscription).permit(:currency)
  end
end
