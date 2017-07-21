class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @payment = Payment.new(currency: params[:currency])
    @payment.payer = current_company
    @payment.subscription = current_company.subscriptions.new
    if @payment.save
      redirect_to @payment
    end
  end

  def show
    @payment = Payment.find_by(unique_token: params[:id])
  end
end
