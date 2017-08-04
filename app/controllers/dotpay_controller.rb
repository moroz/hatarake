class DotpayController < PaymentsController
  def confirm
    @dotpay = DotpayPayment.new(request.raw_post)
    if @dotpay.acknowledge
      @order = Order.find_by(unique_token: @dotpay.control)
      @order.update(payment_status: @dotpay.status)
      logger.info "Received Dotpay payment: #{@dotpay.amount} #{@dotpay.currency.upcase}"
      @order.paid!
    else
      logger.error "Incorrect dotpay payment"
    end
    render plain: 'OK'
  end

  def dotpay_id
    '767542'
  end
end
