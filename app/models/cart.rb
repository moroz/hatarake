class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def total_pln
    sum = cart_items.reduce(0) do |counter, item|
      counter + item.subtotal_pln
    end
  end

  def total_eur
    sum = cart_items.reduce(0) do |counter, item|
      counter + item.subtotal_eur
    end
  end

  def total_to_s
    sprintf("%.2f PLN / %.2f&euro;", total_pln, total_eur).html_safe
  end
end
