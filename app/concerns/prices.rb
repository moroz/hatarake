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

  def self.discounted_price(total, discount)
    difference = total.to_d - discount.to_d
    return 0 if difference <= 0
    difference
  end

  def self.discount(total, balance)
    return 0 if balance.to_i.zero?
    if total <= balance
      total
    else
      balance
    end
  end

  def self.formatted_discounted_price(total, discount, currency = 'pln')
    formatted_price(discounted_price(total, discount), currency)
  end
end
