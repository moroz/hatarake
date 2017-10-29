# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates_numericality_of :quantity, greater_than: 0

  delegate :name, to: :product, prefix: true

  def unit_price(currency: 'pln')
    product.price(currency || 'pln')
  end

  def unit_price_to_s(currency: 'pln')
    if currency
      format('%.2f %s', unit_price(currency: currency), currency.to_s.upcase)
    else
      %w[pln eur].map do |cur|
        format('%.2f %s', unit_price(currency: cur), cur.to_s.upcase)
      end.join(' / ')
    end
  end

  def readonly?
    cart.readonly?
  end

  def subtotal(currency: 'pln', net: false)
    gross = quantity * product["price_#{currency}"]
    return net_price(gross) if net
    gross
  end

  def subtotal_to_s(net: false, currency: nil)
    amount_pln = subtotal(net: net)
    amount_pln = format('%.2f PLN', amount_pln)
    amount_eur = subtotal(currency: :eur, net: net)
    amount_eur = format('%.2f EUR', amount_eur)
    return [amount_pln, amount_eur].join(' / ') unless currency
    return amount_pln if currency.to_sym == :pln
    amount_eur
  end
end
