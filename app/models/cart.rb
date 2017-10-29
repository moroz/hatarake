# frozen_string_literal: true

class Cart < ApplicationRecord
  has_one :order
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  scope :unfinalized, -> { where('NOT finalized') }

  def add_item(product, quantity = 1)
    product = Product.find_by(id: product.to_i) unless product.is_a?(Product)
    return false if !product || quantity.to_i < 1
    if (item = cart_items.find_by(product_id: product))
      item.update(quantity: item.quantity + quantity.to_i)
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def finalize!
    raise if finalized?
    update!(finalized_at: Time.now, finalized: true)
  end

  def readonly?
    saved_change_to_attribute?(:finalized) && finalized?
  end

  def empty?
    cart_items.empty?
  end

  def total(currency: 'pln', net: false)
    amount = cart_items.joins(:product).sum("cart_items.quantity * products.price_#{currency}")
    amount = Prices.net_price(amount) if net
    amount
  end

  def to_h
    cart_items.reduce({}) do |acc, item|
      acc.merge(item.product_id.to_s => item.quantity.to_s)
    end
  end

  def total_to_s(net: false, currency: nil)
    if currency
      Prices.formatted_price(total(currency: currency, net: net), currency)
    else
      Prices.formatted_prices(total(currency: :pln), total(currency: :eur), net: net)
    end
  end
end
