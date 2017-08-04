class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  validates :currency, inclusion: { in: %w( pln eur ) }
  validates :unique_token, :payment_description, presence: true

  BASE_DESCRIPTION = "InJobs.pl Order #"
  before_validation :set_token_description
  before_create :set_total

  scope :paid, -> { where('paid_at IS NOT NULL') }
  scope :unpaid, -> { where(paid_at: nil) }

  def to_param
    unique_token
  end

  def paid!
    raise RuntimeError.new("Order is already paid") if paid_at.present?
    self.transaction do
      self.update!(paid_at: Time.now)
      user.add_premium_services(self.to_h)
    end
  end

  def to_h
    cart.to_h
  end

  private 

  def set_token_description
    self.unique_token ||= SecureRandom.hex(4)
    self.payment_description ||= BASE_DESCRIPTION + unique_token
  end

  def set_total
    self.total = cart.total(currency)
  end
end
