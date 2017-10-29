# frozen_string_literal: true

module Prices
  VAT_RATE = 23
  PRICE_SEPARATOR = '<br/>'

  def self.net_price(price)
    (price * (100.0 / (100 + VAT_RATE))).round(2)
  end

  def self.formatted_price(amount, currency, net: false)
    amount = net_price(amount) if net
    format('%.2f&nbsp;%s', amount, currency.to_s.upcase).html_safe
  end

  def self.formatted_prices(pln, eur, net: false)
    if net
      eur = net_price(eur)
      pln = net_price(pln)
    end
    format('%.2f&nbsp;PLN%s%.2f&nbsp;EUR', pln, PRICE_SEPARATOR, eur).html_safe
  end
end
