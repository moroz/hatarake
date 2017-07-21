class DotpayController < PaymentsController
  def payment
    @payment = Payment.find_by(unique_token: params[:token])
  end

  def confirm
    @dotpay = DotpayPayment.new(request.raw_post)
    if @dotpay.acknowledge
      @payment = Payment.find_by(description: @dotpay.description)
      @payment.update(status: @dotpay.status)
      @payment.subscription.paid!
    else
      logger.error "Incorrect dotpay payment"
    end
    render plain: 'OK'
  end
end
