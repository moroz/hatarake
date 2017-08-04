module DotpayHelper
  def dotpay_id(currency = 'pln')
    if currency == 'eur'
      Rails.application.secrets.dotpay_id_eur || '767542'
    else
      Rails.application.secrets.dotpay_id_pln || '767542'
    end
  end
end
