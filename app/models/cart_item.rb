# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates_numericality_of :quantity, greater_than: 0

  delegate :name, to: :product, prefix: true

  def unit_price(currency: 'pln')
    product.price(currency)
  end

  def unit_price_to_s(currency: 'pln')
    if currency
      Prices.formatted_price(unit_price(currency: currency), currency)
    else
      Prices.formatted_prices(unit_price(currency: :pln), unit_price(currency: :eur))
    end
  end

  def readonly?
    cart.readonly?
  end

  def subtotal(currency: 'pln', net: false)
    gross = quantity * product["price_#{currency}"]
    return Prices.net_price(gross) if net
    gross
  end

  def subtotal_to_s(net: false, currency: nil)
    if currency
      Prices.formatted_price(subtotal(currency: currency), currency, net: net)
    else
      Prices.formatted_prices(subtotal(currency: :pln), subtotal(currency: :eur), net: net)
    end
  end
end
