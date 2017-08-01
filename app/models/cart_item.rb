class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates_numericality_of :quantity, greater_than: 0

  delegate :name, to: :product, prefix: true

  def subtotal_pln
    quantity * product.price_pln
  end

  def subtotal_eur
    quantity * product.price_eur
  end

  def subtotal_to_s
    sprintf("%.2f PLN / %.2f&euro;", subtotal_pln, subtotal_eur).html_safe
  end
end
