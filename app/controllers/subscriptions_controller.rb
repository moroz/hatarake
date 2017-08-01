class SubscriptionsController < ApplicationController
  expose(:subscription)

  helper_method :company

  def index

  end

  def new
    @title = "Premium Accounts"
  end

  def create
    @subscription = current_company.subscriptions.new
    @subscription.currency = params[:currency]
    Subscription.transaction do
      @payment = @subscription.build_payment(currency: params[:currency], payer: current_company)
      @payment.save!
      @subscription.save!
      redirect_to @payment and return
    end
    redirect_to new_subscription_path, alert: "An error occured"
  end

  private

  def company
    @company ||= current_company
  end

  def subscription_params
    params.require(:subscription).permit(:currency)
  end
end
