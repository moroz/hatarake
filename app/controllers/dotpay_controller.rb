class DotpayController < PaymentsController
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

  def dotpay_id
    '767542'
  end
end
