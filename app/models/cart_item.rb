# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates_numericality_of :quantity, greater_than: 0

  delegate :name, to: :product, prefix: true

  def unit_price(currency = 'pln')
    product.price(currency)
  end

  def readonly?
    cart.readonly?
  end

  def subtotal(currency = 'pln')
    quantity * product["price_#{currency}"]
  end

  def subtotal_to_s(net: false)
    amount = subtotal
    amount = net_price(subtotal) if net
    amount_eur = subtotal(:eur)
    amount_eur = net_price(subtotal(:eur)) if net
    format("%.2f PLN / %.2f&euro;", amount, amount_eur).html_safe
  end
end
