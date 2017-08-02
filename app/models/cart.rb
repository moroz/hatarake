class Cart < ApplicationRecord
  has_one :order
  belongs_to :user
  has_many :cart_items

  def readonly?
    order.present?
  end

  def total(currency = 'pln')
    cart_items.reduce(0) do |counter, item|
      counter + item.subtotal(currency)
    end
  end

  def total_to_s
    sprintf("%.2f PLN / %.2f&euro;", total, total(:eur)).html_safe
  end
end
