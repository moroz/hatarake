class Cart < ApplicationRecord
  has_one :order
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  scope :unfinalized, -> { where('NOT finalized') }

  def add_item(product, quantity = 1)
    product = Product.find_by(id: product.to_i) unless product.is_a?(Product)
    return false if !product || quantity.to_i < 1
    if (item = self.cart_items.find_by(product_id: product))
      item.update(quantity: item.quantity + quantity.to_i)
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def finalize!
    raise if finalized?
    self.transaction do
      Order.create!(cart: self, user: user)
      self.update!(finalized_at: Time.now, finalized: true)
    end
  end

  def readonly?
    !changed.include?('finalized') && finalized?
  end

  def empty?
    cart_items.empty?
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
