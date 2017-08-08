class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user, required: true
  has_one :billing_address

  validates :currency, inclusion: { in: %w( pln eur ) }
  validates :unique_token, presence: true

  before_validation :set_token_description
  before_create :set_total

  scope :paid, -> { where('paid_at IS NOT NULL') }
  scope :unpaid, -> { where(paid_at: nil) }

  accepts_nested_attributes_for :billing_address, reject_if: :all_blank

  def to_param
    unique_token
  end

  def paid!
    raise RuntimeError.new("Order is already paid") if paid?
    self.transaction do
      self.update!(paid_at: Time.now)
      user.add_premium_services(self.to_h)
    end
  end

  def paid?
    paid_at.present?
  end

  def to_h
    cart.to_h
  end

  private 

  def set_token_description
    self.unique_token ||= SecureRandom.hex(10)
  end

  def set_total
    self.total = cart.total(currency)
  end
end
