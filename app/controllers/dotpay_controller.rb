# frozen_string_literal: true

class DotpayController < PaymentsController
  def confirm
    @dotpay = DotpayPayment.new(request.raw_post)
    if @dotpay.acknowledge
      @order = Order.find_by(unique_token: @dotpay.control)
      @order.update(payment_status: @dotpay.status)
      if @dotpay.status == 'completed'
        logger.info "Received Dotpay payment: #{@dotpay.amount} #{@dotpay.currency.upcase}"
        @order.paid!
      end
    else
      logger.error 'Unrecognized dotpay payment'
    end
    render plain: 'OK'
  end
end
