# frozen_string_literal: true

class Company < User
  devise :registerable
  has_many :offers, dependent: :destroy
  has_many :applications, through: :offers
  has_many :subscriptions
  has_many :blog_posts, foreign_key: :user_id
  belongs_to :location
  validates :name, uniqueness: true, presence: true

  def self.published_offers
    offers.where('published_at IS NOT NULL')
  end

  accepts_nested_attributes_for :location

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  scope :premium_users, -> { where('premium_until > NOW()') }
  scope :featured, -> { premium_users.order('users.updated_at DESC') }

  def self.search(query)
    where('name ILIKE ?', '%' + sanitize_sql_like(query) + '%')
  end

  def premium?
    premium_until && premium_until > Time.now
  end

  def display_name
    name
  end

  def sex; end

  # balance is the amount of money given to a Company so they can buy premium services
  # when placing an order, Company's balance is reduced, and the same amount is deducted
  # from the order's total to calculate amount due.
  def reduce_balance(total)
    return if balance.nil? || balance.zero?
    discount = Prices.discount(total.to_d, balance)
    update(balance: balance - discount)
    discount
  end
end
