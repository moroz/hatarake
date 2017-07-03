class SubscriptionsController < ApplicationController
  expose(:subscription)

  helper_method :company

  def new

  end

  def create
    subscription.company = company

  end

  private

  def company
    @company ||= current_company
  end
end
