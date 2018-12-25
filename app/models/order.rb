# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user, required: true
  has_one :billing_address

  validates :currency, inclusion: { in: %w[pln eur] }
  validates :unique_token, presence: true

  delegate :cart_items, to: :cart

  before_validation :set_token_description
  before_create :set_total

  before_destroy :revert_balance

  scope :paid, -> { where('paid_at IS NOT NULL') }
  scope :unpaid, -> { where(paid_at: nil) }

  accepts_nested_attributes_for :billing_address, reject_if: :all_blank

  before_validation :clear_billing_address_attributes_if_no_invoice

  def to_param
    unique_token
  end

  def paid!
    raise 'Order is already paid' if paid?

    transaction do
      update!(paid_at: Time.now)
      user.add_premium_services(to_h)
    end
  end

  def self.process_premium_services_hash(hash)
    raise ArgumentError unless hash.is_a?(Hash)

    hash.stringify_keys!
    hash['3'] = hash['3'].to_i
    hash.each do |k, v|
      v = v.to_i
      case k
      when '5' then hash['3'] += 5 * v
      when '6' then hash['3'] += 10 * v
      when '7' then hash['3'] += 15 * v
      end
    end
    hash.except!('3') if hash['3'].zero?
    hash.except!('5', '6', '7')
  end

  def paid?
    paid_at.present?
  end

  def to_h
    cart.to_h
  end

  def net?
    !polish_taxpayer
  end

  def amount_due
    super || total
  end

  private

  def clear_billing_address_attributes_if_no_invoice
    billing_address.destroy if !invoice && billing_address.present?
  end

  def set_token_description
    self.unique_token ||= SecureRandom.hex(10)
  end

  def set_total
    self.total = cart.total(currency: currency, net: net?)
    self.amount_due = total - (deduction || 0)
    self.amount_due = 0 if amount_due.negative?
  end

  def revert_balance
    user.update(balance: user.balance + deduction) if deduction
  end
end
