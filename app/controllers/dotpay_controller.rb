class DotpayController < PaymentsController
  def confirm
    @payment = DotpayPayment.new(request.raw_post)
    if @payment.acknowledge
      logger.info "Dotpay payment acknowledged"
    else
      logger.error "Incorrect dotpay payment"
    end
    render plain: 'OK'
  end
end
