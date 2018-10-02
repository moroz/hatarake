# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :confirmable, :recoverable, :validatable, :trackable

  validates :contact_email, uniqueness: true, allow_blank: true
  validates :phone, uniqueness: true, allow_blank: true
  validates :website, url: true, allow_blank: true
  validates :description, length: { maximum: 10_000 }
  validates :password, presence: true, on: :create

  validates_acceptance_of :terms_of_service, accept: '1', on: :create
  validates_acceptance_of :personal_data, accept: '1', on: :create
  validates_acceptance_of :rodo, accept: '1', on: :create

  has_one :avatar, foreign_key: 'owner_id', dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders
  extend FriendlyId
  friendly_id :name_for_slug, use: [:finders]

  PREMIUM_KEYS = { 'highlight' => 4, 'homepage' => 2, 'category' => 3, 'social' => 8, 'special' => 9 }.freeze

  before_create :set_locale

  after_validation :add_http_to_website

  def company?
    type == 'Company'
  end

  def candidate?
    type == 'Candidate'
  end

  def set_locale(locale = I18n.locale)
    self.locale = locale
    save if persisted?
  end

  def renew_premium_employer(duration)
    if premium_until.present? && premium_until > Time.now
      update(premium_until: premium_until + duration.months)
    else
      update(premium_until: Time.now + duration.months)
    end
  end

  def add_premium_services(hash)
    hash = Order.process_premium_services_hash(hash)
    renew_premium_employer(hash.delete('1').to_i) if hash.key?('1')
    if premium_services.nil?
      new_hash = hash
    else
      new_hash = premium_services.stringify_keys
      hash.each_key do |k|
        new_hash[k] = if new_hash.key?(k)
                        hash[k].to_i + new_hash[k].to_i
                      else
                        hash[k].to_i
                      end
      end
    end
    update(premium_services: new_hash)
  end

  def reduce_premium_services(key, value)
    key = PREMIUM_KEYS[key] if key.is_a?(String) && key.to_i.zero?
    if premium_services.blank? || !premium_services.key?(key.to_s) || (premium_services[key.to_s].to_i < value.to_i)
      return false
    end
    balance = premium_services[key.to_s].to_i
    new_hash = premium_services.dup
    if balance == value.to_i
      new_hash.delete(key.to_s)
    else
      new_hash[key.to_s] = balance - value.to_i
    end
    update!(premium_services: new_hash)
    true
  end

  protected

  def add_http_to_website
    self.website = add_http_to_url(website)
  end
end
