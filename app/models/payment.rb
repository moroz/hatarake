class Payment < ApplicationRecord
  belongs_to :subscription
  validates_presence_of :currency, :description
  belongs_to :payer, class_name: 'Company'

  before_validation :set_description, :set_amount

  def to_param
    unique_token
  end

  private

  def set_description
    self.unique_token ||= SecureRandom.hex(4)
    self.description ||= Subscription::PAYMENT_TITLE + unique_token
  end

  def set_amount
    self.amount ||= Subscription::PRICES[currency]
  end

  
end
