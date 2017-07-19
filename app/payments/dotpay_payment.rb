class DotpayPayment
  def initialize(raw_post, secret: Rails.application.secrets.dotpay_secret)
    @secret = secret
    @data = CGI::parse(raw_post)
  end

  def acknowledge
    sum = @secret.to_s + @data.map { |k,v| v[0] unless k == 'signature' }.join('')
    Digest::SHA256.hexdigest(sum) == @data['signature'][0]
  end
end
