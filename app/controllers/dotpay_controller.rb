class DotpayController < PaymentsController
  def confirm
    @dotpay = DotpayPayment.new(request.raw_post)
    if @dotpay.acknowledge
      @order = Order.find_by(payment_description: @dotpay.description)
      @order.update(status: @dotpay.status)
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
