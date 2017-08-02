class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  validates :currency, inclusion: { in: %w( pln eur ) }
  validates :unique_token, :payment_description, presence: true

  BASE_DESCRIPTION = "InJobs.pl Order #"
  before_validation :set_token_description
  before_create :set_total

  def to_param
    unique_token
  end

  def paid!
    self.update(paid_at: Time.now)
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
