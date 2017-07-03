class Subscription < ApplicationRecord
  belongs_to :company, required: true

  attr_accessor :duration_in_months

  scope :valid, -> { where('valid_until > NOW()') }

  scope :paid, -> { where('paid') }
  scope :unpaid, -> { where('NOT paid') }

  before_validation :set_duration, :set_price

  def active?
    !!valid_until && valid_until > Time.now
  end

  def paid!
    return false if paid
    if company.has_valid_subscription?
      self.valid_until = company.last_subscription.valid_until + duration
    else
      self.valid_until = Time.now + duration
    end
    self.paid = true
    self.paid_at = Time.now
    self.save!
    true
  end

  private

  def set_duration
    if duration_in_months.present?
      # convert months to duration in seconds
      self.duration = duration_in_months * 30 * 86400
      self.price = nil
    end
  end

  def set_price
    if price.nil?
      self.price = SubscriptionPrice.find_by(duration: self.duration).try(:price)
    end
  end
end
