# frozen_string_literal: true

class Subscription < ApplicationRecord
  # This is a class used to order Premium Employer Bundles
  # and nothing else, really
  belongs_to :company, required: true
  belongs_to :payment, required: true

  before_create :set_price

  attr_accessor :currency

  scope :valid, -> { where('valid_until > NOW()') }

  scope :paid, -> { where('paid') }
  scope :unpaid, -> { where('NOT paid') }

  PRICES = { 'eur' => 12.30, 'pln' => 49.19 }.freeze
  DURATION = 2592000 # 30 days
  PAYMENT_TITLE = 'InJobs.pl Premium Employer '

  def active?
    !!valid_until && valid_until > Time.now
  end

  def paid!
    return false if paid
    self.valid_until = if company.has_valid_subscription?
                         company.last_subscription.valid_until + duration
                       else
                         Time.now + duration
                       end
    self.paid = true
    self.paid_at = Time.now
    save!
    true
  end

  private

  def set_price
    self.price ||= PRICES[currency]
  end
end
