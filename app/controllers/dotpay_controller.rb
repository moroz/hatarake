class DotpayController < PaymentsController
  def payment
    @payment = Payment.find_by(unique_token: params[:token])
    post_data = {
      id: dotpay_id,
      amount: @payment.amount,
      currency: @payment.currency.upcase,
      description: @payment.description
    }
    uri = URI.parse("https://ssl.dotpay.pl/test_payment/")
    response = Net::HTTP.post_form(uri, post_data)
    binding.pry
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

  def dotpay_id
    '767542'
  end
end
