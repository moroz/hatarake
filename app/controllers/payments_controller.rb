class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @payment = Payment.find_by(unique_token: params[:id])
  end
end
