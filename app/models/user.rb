class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :confirmable, :recoverable
  validates :email, presence: true, uniqueness: true
  validates :contact_email, uniqueness: true, allow_blank: true
  validates :phone, uniqueness: true, allow_blank: true
  validates :website, url: true, allow_blank: true
  has_one :avatar, foreign_key: 'owner_id'
  has_many :carts
  extend FriendlyId
  friendly_id :name_for_slug, use: [:finders]

  before_create :set_locale

  after_validation :add_http_to_website

  def company?
    self.type == "Company"
  end

  def candidate?
    self.type == "Candidate"
  end

  def set_locale(locale = I18n.locale)
    self.locale = locale
    self.save if self.persisted?
  end

  def renew_premium_employer(months)
    if self.premium_until.present?
      update(premium_until: premium_until + months.months)
    else
      update(premium_until: months.months.from_now)
    end
  end

  def add_premium_services(hash)
    raise ArgumentError unless hash.is_a?(Hash)
    hash.stringify_keys!
    if hash.key?('1')
      renew_premium_employer(hash.delete('1').to_i)
    end
    if self.premium_services.nil?
      new_hash = hash
    else
      new_hash = self.premium_services.stringify_keys
      hash.each do |k,v|
        if new_hash.key?(k)
          new_hash[k] = hash[k].to_i + new_hash[k].to_i
        else
          new_hash[k] = hash[k].to_i
        end
      end
    end
    self.update(premium_services: new_hash)
  end

  protected

  def add_http_to_website
    self.website = add_http_to_url(website)
  end
end
