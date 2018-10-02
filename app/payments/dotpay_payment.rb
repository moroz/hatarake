# frozen_string_literal: true

class DotpayPayment
  PAYMENT_STATUSES = %w[new processing completed rejected processing_realization_waiting processing_realization].freeze

  def initialize(raw_post, secret: Rails.application.secrets.dotpay_secret)
    @secret = secret
    @data = CGI.parse(raw_post)
  end

  def acknowledge
    return false unless PAYMENT_STATUSES.include?(status)
    sum = @secret.to_s + @data.map { |k, v| v[0] unless k == 'signature' }.join('')
    Digest::SHA256.hexdigest(sum) == @data['signature'][0]
  end

  def status
    @data['operation_status'][0]
  end

  def control
    @data['control'][0]
  end

  def amount
    str = @data['operation_original_amount'][0]
    str.present? && str.to_d
  end

  def currency
    @data['operation_original_currency'][0]
  end

  def description
    @data['description'][0]
  end

  def time
    str = @data['operation_datetime'][0]
    str.present? && Time.parse(str)
  end
end
