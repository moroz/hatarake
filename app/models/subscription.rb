class Subscription < ApplicationRecord
  belongs_to :company, required: true

  scope :valid, -> { where('valid_until > NOW()') }

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
end
