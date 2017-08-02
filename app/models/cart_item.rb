class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates_numericality_of :quantity, greater_than: 0

  delegate :name, to: :product, prefix: true

  def readonly?
    cart.readonly?
  end

  def subtotal(currency = 'pln')
    quantity * product["price_#{currency}"]
  end

  def subtotal_to_s
    sprintf("%.2f PLN / %.2f&euro;", subtotal, subtotal(:eur)).html_safe
  end
end
